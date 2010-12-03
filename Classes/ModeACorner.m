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
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner_top_left.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_TOPRIGHT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner_top_right.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_BOTRIGHT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner_bot_right.png"]];
		[self addSubview:background];
	}
	
	if ([cornerType isEqualToString:CORNER_BOTLEFT]) {
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner_bot_left.png"]];
		[self addSubview:background];

	}
	
}



- (void)setWorld:(b2World *)world {
	
	
	
	CGPoint p = self.center;
	CGSize screenSize = self.superview.bounds.size;
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.height-p.y)/PTM_RATIO);
	//bodyDef.userData = self;
	//bodyDef.type = b2_dynamicBody;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	b2FixtureDef fixtureDef;
	fixtureDef.filter.groupIndex = -8;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.9f;
	fixtureDef.restitution = 0.75f;
	
		
	if ([cornerType isEqualToString:CORNER_BOTLEFT]) {
		
		centerVec.Set((-40)/PTM_RATIO,-7/PTM_RATIO);
		shape.SetAsBox(88/PTM_RATIO/2, 264/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
		
		centerVec.Set(0,(-73)/PTM_RATIO);
		shape.SetAsBox(168/PTM_RATIO/2, 132/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
	}
	
	if ([cornerType isEqualToString:CORNER_BOTRIGHT]) {
		
		centerVec.Set((40)/PTM_RATIO,-7/PTM_RATIO);
		shape.SetAsBox(88/PTM_RATIO/2, 264/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
		
		centerVec.Set(0,(-73)/PTM_RATIO);
		shape.SetAsBox(168/PTM_RATIO/2, 132/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
		
	}
	
	if ([cornerType isEqualToString:CORNER_TOPLEFT]) {
		
		centerVec.Set((-40+7)/PTM_RATIO,+7/PTM_RATIO);
		shape.SetAsBox(88/PTM_RATIO/2, 264/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
		
		centerVec.Set(-7/PTM_RATIO,(88+7)/PTM_RATIO);
		shape.SetAsBox(168/PTM_RATIO/2, 88/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
	}
	
	
	if ([cornerType isEqualToString:CORNER_TOPRIGHT]) {
		
		centerVec.Set((40+7)/PTM_RATIO,7/PTM_RATIO);
		shape.SetAsBox(88/PTM_RATIO/2, 264/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
		
		centerVec.Set(7/PTM_RATIO,(88+7)/PTM_RATIO);
		shape.SetAsBox(168/PTM_RATIO/2, 88/PTM_RATIO/2, centerVec, 0);
		fixtureDef.shape = &shape;		
		fixture = body->CreateFixture(&fixtureDef);
	}
	

	
}


- (void)dealloc {
    [super dealloc];
}


@end
