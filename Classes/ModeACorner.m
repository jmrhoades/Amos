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
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	CGContextRef X = UIGraphicsGetCurrentContext();
	CGContextSetAllowsAntialiasing(X, NO);
    CGRect bounds =  CGContextGetClipBoundingBox(X);
    CGPoint center = CGPointMake((bounds.size.width / 2), (bounds.size.height / 2));
    //NSLog(@"--> (drawRect) bounds:'%@'", NSStringFromCGRect(bounds));
    CGContextSetRGBFillColor(X, 0, 0, 0, 1.0);
	CGContextBeginPath(X);
    CGContextMoveToPoint(X, 0, 0);
	
	if ([cornerType isEqualToString:CORNER_TOPLEFT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 128-32.0, 128.0));
		CGContextFillRect(X, CGRectMake(128-32.0, 0.0, 32.0, 128.0-32));
	}
	
	if ([cornerType isEqualToString:CORNER_TOPRIGHT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 32, 128-32));
		CGContextFillRect(X, CGRectMake(32.0, 0.0, 128-32.0, 128));
	}
	
	if ([cornerType isEqualToString:CORNER_BOTRIGHT]) {
		CGContextFillRect(X, CGRectMake(0.0, 32.0, 32, 128-32));
		CGContextFillRect(X, CGRectMake(32.0, 0.0, 128-32.0, 128));
	}
	
	if ([cornerType isEqualToString:CORNER_BOTLEFT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 128-32.0, 128.0));
		CGContextFillRect(X, CGRectMake(128-32.0, 32.0, 32.0, 128.0-32));
	}
    
	
}

- (void)setWorld:(b2World *)world {
	
	//bodyDef.type = b2_dynamicBody;
	CGPoint p = self.center;
	CGRect screen = [[UIScreen mainScreen] bounds];
	bodyDef.position.Set(p.x/PTM_RATIO, (screen.size.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	body = world->CreateBody(&bodyDef);		
	
	
	if ([cornerType isEqualToString:CORNER_TOPLEFT]) {
		b2PolygonShape rect1, rect2;
		b2Vec2 centerVec;
		centerVec.Set(-16/PTM_RATIO,0);
		rect1.SetAsBox((128-32)/PTM_RATIO/2, 128/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &rect1;	
		fixtureDef.density = 3.0f;
		fixtureDef.friction = 0.9f;
		fixtureDef.restitution = 0.75f;
		centerVec.Set(48/PTM_RATIO,16/PTM_RATIO);
		rect2.SetAsBox(32/PTM_RATIO/2, (128-32)/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef2;
		fixtureDef2.shape = &rect2;	
		fixtureDef2.density = 3.0f;
		fixtureDef2.friction = 0.9f;
		fixtureDef2.restitution = 0.75f;
		body->CreateFixture(&fixtureDef);
		body->CreateFixture(&fixtureDef2);
	}
	
	if ([cornerType isEqualToString:CORNER_TOPRIGHT]) {
		b2PolygonShape rect1, rect2;
		b2Vec2 centerVec;
		centerVec.Set(-48/PTM_RATIO,16/PTM_RATIO);
		rect1.SetAsBox(32/PTM_RATIO/2, (128-32)/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &rect1;	
		fixtureDef.density = 3.0f;
		fixtureDef.friction = 0.9f;
		fixtureDef.restitution = 0.75f;
		body->CreateFixture(&fixtureDef);
		
		
		centerVec.Set(16/PTM_RATIO,0);
		rect2.SetAsBox((128-32)/PTM_RATIO/2, 128/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef2;
		fixtureDef2.shape = &rect2;	
		fixtureDef2.density = 3.0f;
		fixtureDef2.friction = 0.9f;
		fixtureDef2.restitution = 0.75f;
		body->CreateFixture(&fixtureDef2);
		
	}
	
	if ([cornerType isEqualToString:CORNER_BOTRIGHT]) {
		b2PolygonShape rect1, rect2;
		b2Vec2 centerVec;
		centerVec.Set(-48/PTM_RATIO,-16/PTM_RATIO);
		rect1.SetAsBox(32/PTM_RATIO/2, (128-32)/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &rect1;	
		fixtureDef.density = 3.0f;
		fixtureDef.friction = 0.9f;
		fixtureDef.restitution = 0.75f;
		body->CreateFixture(&fixtureDef);
		
		
		centerVec.Set(16/PTM_RATIO,0);
		rect2.SetAsBox((128-32)/PTM_RATIO/2, 128/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef2;
		fixtureDef2.shape = &rect2;	
		fixtureDef2.density = 3.0f;
		fixtureDef2.friction = 0.9f;
		fixtureDef2.restitution = 0.75f;
		body->CreateFixture(&fixtureDef2);
		
	}
	
	if ([cornerType isEqualToString:CORNER_BOTLEFT]) {
		b2PolygonShape rect1, rect2;
		b2Vec2 centerVec;
		centerVec.Set(-16/PTM_RATIO,0);
		rect1.SetAsBox((128-32)/PTM_RATIO/2, 128/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &rect1;	
		fixtureDef.density = 3.0f;
		fixtureDef.friction = 0.9f;
		fixtureDef.restitution = 0.75f;
		centerVec.Set(48/PTM_RATIO,-16/PTM_RATIO);
		rect2.SetAsBox(32/PTM_RATIO/2, (128-32)/PTM_RATIO/2, centerVec, 0);
		b2FixtureDef fixtureDef2;
		fixtureDef2.shape = &rect2;	
		fixtureDef2.density = 3.0f;
		fixtureDef2.friction = 0.9f;
		fixtureDef2.restitution = 0.75f;
		body->CreateFixture(&fixtureDef);
		body->CreateFixture(&fixtureDef2);
	}
	
	
}


- (void)dealloc {
    [super dealloc];
}


@end
