//
//  ShapeBase.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/6/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"
#import "ShapeBase.h"
#import "AmosAppDelegate.h"
#import "ModeAViewController.h"
#import "AmosMIDIManager.h"
#import "NoteSetting.h"


@implementation ShapeBase


@synthesize container;
@synthesize isOn;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.isOn = NO;
    }
    return self;
}

- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	CGSize screenSize = delegate.modeA.view.bounds.size;
	CGPoint p = self.center;
		
	// Body def
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	
	// Shape def
	circleShape.m_radius = 80/PTM_RATIO;
	
	// Fixture def
	fixtureDef.shape = &circleShape;	
	fixtureDef.density = 10.0f;
	fixtureDef.friction = 0.1f;
	fixtureDef.restitution = .975f; // 0 is a lead ball, 1 is a super bouncy ball
	
}

-(void) turnOn {
	if (self.isOn == NO) {
		
		body = world->CreateBody(&bodyDef);		
		self.fixture = body->CreateFixture(&fixtureDef);

		self.isOn = YES;
		[container addSubview:self];
	}

}


-(void) turnOff {
	
	if (self.isOn) {
		world->DestroyBody(self.body);
		[self removeFromSuperview];
		self.isOn = NO;
	}
	
}





-(void) panBegan {
	
	
	
	[UIView animateWithDuration:.33
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 panLight.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 ;}];
	
	
}

-(void) panEnded {
	
	
	[UIView animateWithDuration:.83
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 panLight.alpha = 0;
					 }
					 completion:^(BOOL finished){
						 ;}];
	 
}



- (void)playNote:(int)note withVelocity:(int)vel {

	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	float interval = (delegate.midiManager.beatLength * duration)/1000;

	NSNumber *tNote = [NSNumber numberWithInt:note];
	NSDictionary *userInfo =  [NSDictionary dictionaryWithObject:tNote forKey:@"note"];
	
	[delegate.midiManager playNote:note withVelocity:vel];
	
	//interval = 1;
	
	//NSLog(@"ShapeBase playNote %f %i", interval, vel);
	
	[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(stopNoteByTimer:) userInfo:userInfo repeats:NO];
	
	[UIView animateWithDuration:.01
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 noteOn.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:interval
											   delay:0
											 options:UIViewAnimationOptionAllowUserInteraction
										  animations:^{
											  noteOn.alpha = 0;
										  }
										  completion:^(BOOL finished){
											  ;
										  }
						  ];}];
	
}



- (void)stopNoteByTimer:(NSTimer*)theTimer  {
	//NSLog(@"ShapeBase: stopNoteByTimer.");
	
	NSNumber *note = [[theTimer userInfo] objectForKey:@"note"];
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	[delegate.midiManager endNote:[note intValue]];
	//[libdsmi writeMIDIMessage:NOTE_OFF MIDIChannel:0 withData1:[note intValue] withData2:30];
	
}



- (void)dealloc {
    [super dealloc];
}


@end
