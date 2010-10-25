//
//  ModeANoteBlock.m
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "ModeANoteBlock.h"
#import "ModeAViewController.h"
#import "AmosAppDelegate.h"
#import "AmosMIDIManager.h"
#import "QuartzCore/QuartzCore.h"

@implementation ModeANoteBlock

@synthesize fixture;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		
		/*
		 Create a tap recognizer and add it to the view.
		 Keep a reference to the recognizer to test in gestureRecognizer:shouldReceiveTouch:.
		 */
		tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
		[self addGestureRecognizer:tapRecognizer];
		tapRecognizer.delegate = self;
		
		
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos1_noteblock_base_128x128.png"]];
		base.backgroundColor = [UIColor clearColor];
		base.opaque = NO;
		[self addSubview:base];
		
		
		noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 54, 100, 14)];
		noteLabel.backgroundColor = [UIColor clearColor];
		noteLabel.opaque = NO;		
		noteLabel.textAlignment = UITextAlignmentCenter;
		noteLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.5];
		noteLabel.textColor = [UIColor colorWithRed:1.0*86/256 green:1.0*88/256 blue:1.0*92/256 alpha:.95];
		noteLabel.shadowOffset = CGSizeMake(0,-1);
		noteLabel.font = [UIFont systemFontOfSize:13.0];
		[self addSubview:noteLabel];

	
		light = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos1_noteblock_light_128x128.png"]];
		light.backgroundColor = [UIColor clearColor];
		light.opaque = NO;
		light.alpha = 0;
		[self addSubview:light];
		
		
    }
    return self;
}



- (void) setNoteValue:(int)note {
	noteValue = note;
	NSLog(@"noteValue: %i", noteValue);

	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *name = [delegate.midiManager.midiNoteNamesMap objectAtIndex:noteValue];
	NSLog(@"midiNoteNamesMap: %@", delegate.midiManager.midiNoteNamesMap);

	NSLog(@"name: %@", name);

	noteLabel.text = name;
}


- (void) setBlockType:(NSString *)type {
	blockType = type;
	float angle = 0;
	
	if ([blockType isEqualToString:BLOCK_TOP]) {
		angle = 0;
	}
	
	if ([blockType isEqualToString:BLOCK_RIGHT]) {
		angle = 90;
	}
	
	if ([blockType isEqualToString:BLOCK_LEFT]) {
		angle = 270;
	}
	
	if ([blockType isEqualToString:BLOCK_BOT]) {
		angle = 180;
	}
	
	CGAffineTransform transform = CGAffineTransformMakeRotation( (angle * 3.14159265) / 180 );
	base.layer.affineTransform = transform;
	baseContact.layer.affineTransform = transform;	
	noteLabel.layer.affineTransform = transform;	
	light.layer.affineTransform = transform;
	
}



- (void)playNote:(int)note withVelocity:(int)vel {

	//NSLog(@"Note block hit Hit!");

	[UIView animateWithDuration:.01
			delay:0
			options:UIViewAnimationOptionAllowUserInteraction
			animations:^{ 
				light.alpha = 1;
			}
			completion:^(BOOL finished){
	[UIView animateWithDuration:.33
			delay:0
			options:UIViewAnimationOptionAllowUserInteraction
			animations:^{
				light.alpha = 0;
			}
			completion:^(BOOL finished){
				;
			}
	];}];
	
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager playNote:note withVelocity:vel];
	
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    
    //CGPoint location = [recognizer locationInView:self.view];
    
    [self playNote:noteValue withVelocity:64];
}

- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	world = aWorld;	
	groundBody = aGroundBody;
	
		
	//bodyDef.type = b2_dynamicBody;
	CGPoint p = self.center;
	
	CGRect screenSize = [[UIScreen mainScreen] bounds];
	// TEMP - SHOULD BE BASED ON ORIENTATION, NOT FIXED
	// Need to account for Top Tool Bar Height
	screenSize.size.height = screenSize.size.height - 44;
	
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.size.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	centerVec.Set(0,0);
	b2FixtureDef fixtureDef;
	fixtureDef.density = 3.0f;
	fixtureDef.friction = 0.9f;
	fixtureDef.restitution = 0.75f;
	shape.SetAsBox(96/PTM_RATIO/2, 96/PTM_RATIO/2, centerVec, 0);
	fixtureDef.shape = &shape;	
	fixture = body->CreateFixture(&fixtureDef);
	
	
	
}


- (void)dealloc {
    [super dealloc];
}


@end
