//
//  ShapeCircle.m
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

#import "ShapeCircle.h"


@implementation ShapeCircle

@synthesize circleSize;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
				
    }
    return self;
}


- (void) setCircleSize:(NSString *)circSize {
	
	circleSize = circSize;
	
	if (circleSize == CIRCLE_WHOLE_NOTE) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_whole_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_whole_on.png"]];
		duration = 4;
	}
	
	if (circleSize == DISC_LARGE) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_pan.png"]];			
		duration = 2;


	}
	
	if (circleSize == DISC_MEDIUM) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_pan.png"]];			
		duration = 1;		
	}
	
	if (circleSize == DISC_SMALL) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_pan.png"]];			
		
		duration = .5;	
	}
	
	if (circleSize == CIRCLE_SIXTEENTH_NOTE) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_sixteenth_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_sixteenth_on.png"]];
		duration = .25;	

	}
	
	
	base.backgroundColor = [UIColor clearColor];
	base.opaque = NO;
	[self addSubview:base];
	
	noteOn.backgroundColor = [UIColor clearColor];
	noteOn.opaque = NO;
	noteOn.alpha = 0;
	[self addSubview:noteOn];
	
	
	panLight.backgroundColor = [UIColor clearColor];
	panLight.opaque = NO;
	panLight.alpha = 0;
	[self addSubview:panLight];
	
	
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
	fixtureDef.density = 1.0f;	
	fixtureDef.restitution = 1.0f;				
	float32 size;
	
	// Shape def
	if (circleSize == CIRCLE_SIXTEENTH_NOTE) {
		size = 64/PTM_RATIO;
	}
	if (circleSize == DISC_SMALL) {
		size = 72/PTM_RATIO;
		size = 4.5;	
	}
	if (circleSize == DISC_MEDIUM) {
		size = 80/PTM_RATIO;
		fixtureDef.friction = 0.15f;
	}
	if (circleSize == DISC_LARGE) {
		size = 88/PTM_RATIO;
		size = 5.5f;
		fixtureDef.friction = 0.2f;
	}
	if (circleSize == CIRCLE_WHOLE_NOTE) {
		size = 96/PTM_RATIO;
		fixtureDef.friction = 0.4f;
	}
	
	circleShape.m_radius = size;
	fixtureDef.shape = &circleShape;	
}




- (void)dealloc {
    [super dealloc];
}


@end
