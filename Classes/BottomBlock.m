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


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_bottom.png"]];
		[self addSubview:background];
		
		up = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_bottom_up.png"]];
		up.center = CGPointMake(216, 121.5);
		[self addSubview:up];
		
		up_on = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_bottom_up_on.png"]];
		up_on.center = CGPointMake(216, 121.5);
		up_on.alpha = 0;
		[self addSubview:up_on];

		
    }
    return self;
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
	bodyDef.linearDamping = .8f;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	
	
	b2FixtureDef fixtureDef;
	fixtureDef.filter.groupIndex = -8;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = .9f;
	fixtureDef.restitution = 0.0f;
	
	
	centerVec.Set(0,-51/PTM_RATIO);
	shape.SetAsBox(432/PTM_RATIO/2, 44/PTM_RATIO/2, centerVec, 0);
	fixtureDef.shape = &shape;		
	fixture = body->CreateFixture(&fixtureDef);
}

- (void) playNote {
	
	[UIView animateWithDuration:.01
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 up_on.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:.33
											   delay:0
											 options:UIViewAnimationOptionAllowUserInteraction
										  animations:^{
											  up_on.alpha = 0;
										  }
										  completion:^(BOOL finished){
											  ;
										  }
						  ];}];
	
	
	
	
		
	
	
}



- (void)dealloc {
    [super dealloc];
}


@end
