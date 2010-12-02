//
//  NoteBlock.m
//  Amos
//
//  Created by Justin Rhoades on 10/27/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "NoteBlock.h"

#import "AmosAppDelegate.h"
#import "ModeAViewController.h"
#import "AmosMIDIManager.h"
#import "QuartzCore/QuartzCore.h"
#import "NoteSetting.h"

@implementation NoteBlock

@synthesize noteLabel;
@synthesize noteIndex;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"note_block_base.png"]];
		base.backgroundColor = [UIColor clearColor];
		base.opaque = NO;
		[self addSubview:base];
		
		baseContact = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"note_block_down.png"]];
		baseContact.backgroundColor = [UIColor clearColor];
		baseContact.opaque = NO;
		baseContact.alpha = 0;
		[self addSubview:baseContact];
		
		noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 54, 100, 14)];
		noteLabel.backgroundColor = [UIColor clearColor];
		noteLabel.opaque = NO;		
		noteLabel.textAlignment = UITextAlignmentCenter;
		noteLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.85];
		noteLabel.textColor = [UIColor colorWithRed:1.0*109/256 green:1.0*114/256 blue:1.0*125/256 alpha:.95];
		noteLabel.shadowOffset = CGSizeMake(0,-1);
		noteLabel.font = [UIFont systemFontOfSize:12.0];
		[self addSubview:noteLabel];
		
		light = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"note_block_light.png"]];
		light.backgroundColor = [UIColor clearColor];
		light.opaque = NO;
		light.alpha = 0;
		[self addSubview:light]; 
		
		mouseJointMaxForce = 1260.0f;

    }
    return self;
}

- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	CGPoint p = self.center;	
	CGSize screenSize = self.superview.bounds.size;
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	bodyDef.fixedRotation = true;
	bodyDef.linearDamping = .8f;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	centerVec.Set(0,0);
	b2FixtureDef fixtureDef;
	fixtureDef.filter.groupIndex = -8;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = .9f;
	fixtureDef.restitution = 0.0f;
	shape.SetAsBox(96/PTM_RATIO/2, 96/PTM_RATIO/2, centerVec, 0);
	fixtureDef.shape = &shape;	
	fixture = body->CreateFixture(&fixtureDef);
}

- (void) setNoteValue:(int)note {
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	int maxNote = [delegate.midiManager.midiNoteRange count] - 1;
	if (note < 0) {
		note = maxNote;
	} 
	if (note > maxNote) {
		note = 0;
	}
	noteIndex = note;
	NoteSetting *noteSetting = [delegate.midiManager.midiNoteRange objectAtIndex:noteIndex];
	noteValue = noteSetting.value;
	noteLabel.text = noteSetting.label;
	//NSLog(@"noteValue: %i", note);
}

- (void)playNote:(int)note withVelocity:(int)vel {
	
	//NSLog(@"Note block hit Hit!");
	
	//[self.superview bringSubviewToFront:self];

	
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
	
	
	//AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[delegate.midiManager playNote:noteValue withVelocity:vel];
	 
	
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


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//[self playNote:noteValue withVelocity:100];
	
	
	[UIView animateWithDuration:.01
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 light.alpha = 1;
						 baseContact.alpha = 1;
						 base.alpha = 0;
						 
					 }
					 completion:^(BOOL finished){
					
					}];
	
	[self.superview sendSubviewToBack:self];
	
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager playNote:noteValue withVelocity:120];


	
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[self endNote];
		
}


-(void) panEnded {
	
	[self endNote];

	
}

-(void) endNote {
	
	[UIView animateWithDuration:.13
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 light.alpha = 0;
						 baseContact.alpha = 0;
						 base.alpha = 1;						 
					 }
					 completion:^(BOOL finished){
					 }];
	
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager endNote:noteValue];
	
}








- (void)dealloc {
    [super dealloc];
}


@end
