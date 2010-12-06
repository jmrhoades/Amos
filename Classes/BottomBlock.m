//
//  BottomBlock.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/9/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "BottomBlock.h"

#import "AmosAppDelegate.h"
#import "ModeAViewController.h"
#import "AmosMIDIManager.h"
#import "QuartzCore/QuartzCore.h"
#import "NoteSetting.h"

@implementation BottomBlock

@synthesize controller;
@synthesize isOn;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_bottom.png"]];
		[self addSubview:background];
		
		image_off = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bounce_off.png"]];
		image_off.center = CGPointMake(216, 122);
		image_off.backgroundColor = [UIColor clearColor];
		image_off.opaque = NO;
		image_off.alpha = 0;
		[self addSubview:image_off];
		
		image_on = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bounce_on.png"]];
		image_on.center = image_off.center;
		image_on.backgroundColor = [UIColor clearColor];
		image_on.opaque = NO;
		image_on.alpha = 1;
		[self addSubview:image_on];
		
		image_active = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bounce_active.png"]];
		image_active.center = image_off.center;
		image_active.backgroundColor = [UIColor clearColor];
		image_active.opaque = NO;
		image_active.alpha = 0;
		[self addSubview:image_active];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
		[tapGesture setDelegate:self];
		[self addGestureRecognizer:tapGesture];
		[tapGesture release];
		
		self.isOn = YES;
	
    }
    return self;
}

- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer {
	
	[self toggle];
	
}

- (void) toggle {
	
	self.isOn = !self.isOn;
	
	if (self.isOn) {
		image_off.alpha = 0;
		image_on.alpha = 1;
	} else {
		image_off.alpha = 1;
		image_on.alpha = 0;
	}
}


- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	CGPoint p = self.center;	
	CGSize screenSize = self.superview.bounds.size;
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	b2BodyDef bodyDef;
	
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	bodyDef.fixedRotation = true;
	bodyDef.linearDamping = 0.0f;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	
	
	b2FixtureDef fixtureDef;
	fixtureDef.filter.groupIndex = -8;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution = 0.0f;
	
	
	centerVec.Set(0,-51/PTM_RATIO);
	shape.SetAsBox(432/PTM_RATIO/2, 44/PTM_RATIO/2, centerVec, 0);
	fixtureDef.shape = &shape;		
	fixture = body->CreateFixture(&fixtureDef);
}

- (void) playNote {
	
	if (self.isOn) {
	
	[UIView animateWithDuration:.01
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 image_active.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:.33
											   delay:0
											 options:UIViewAnimationOptionAllowUserInteraction
										  animations:^{
											  image_active.alpha = 0;
										  }
										  completion:^(BOOL finished){
											  ;
										  }
						  ];}];
	
	
	}
	
		
	
	
}



- (void)dealloc {
    [super dealloc];
}


@end
