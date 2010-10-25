//
//  ModeACorner.m
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "ModeACorner.h"
#import "ModeAViewController.h"


@implementation ModeACorner

@synthesize fixture;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}


- (void) setCornerType:(NSString *)type {

	cornerType = type;
	
	if ([cornerType isEqualToString:CORNER_TOPLEFT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_corner_top_left.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_TOPRIGHT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_corner_top_right.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_BOTRIGHT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_corner_bot_right.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_BOTLEFT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_corner_bot_left.png"]];
		[self addSubview:background];

	}
}



- (void)setWorld:(b2World *)world {
	
	
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
