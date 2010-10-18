//
//  ModeANoteBlock.m
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "ModeANoteBlock.h"
#import "ModeAViewController.h"


@implementation ModeANoteBlock


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}


- (void) setBlockType:(NSString *)type {
	blockType = type;
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
	
	if ([blockType isEqualToString:BLOCK_TOP]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 64.0, 96.0));
	}
	
	if ([blockType isEqualToString:BLOCK_RIGHT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 96.0, 64.0));
	}
	
	if ([blockType isEqualToString:BLOCK_LEFT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 96.0, 64.0));
	}
	
	if ([blockType isEqualToString:BLOCK_BOT]) {
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 64.0, 96.0));
	}

}

- (void)setWorld:(b2World *)world {
	
	//bodyDef.type = b2_dynamicBody;
	CGPoint p = self.center;
	CGRect screen = [[UIScreen mainScreen] bounds];
	bodyDef.position.Set(p.x/PTM_RATIO, (screen.size.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	body = world->CreateBody(&bodyDef);
	b2PolygonShape shape;
	b2Vec2 centerVec;
	centerVec.Set(0,0);
	b2FixtureDef fixtureDef;
	fixtureDef.density = 3.0f;
	fixtureDef.friction = 0.9f;
	fixtureDef.restitution = 0.75f;
	
	if ([blockType isEqualToString:BLOCK_TOP]) {
		shape.SetAsBox(64/PTM_RATIO/2, 96/PTM_RATIO/2, centerVec, 0);
	}
	
	if ([blockType isEqualToString:BLOCK_RIGHT]) {
		shape.SetAsBox(96/PTM_RATIO/2, 64/PTM_RATIO/2, centerVec, 0);
	}
	
	if ([blockType isEqualToString:BLOCK_LEFT]) {
		shape.SetAsBox(96/PTM_RATIO/2, 64/PTM_RATIO/2, centerVec, 0);
	}
	
	if ([blockType isEqualToString:BLOCK_BOT]) {
		shape.SetAsBox(64/PTM_RATIO/2, 96/PTM_RATIO/2, centerVec, 0);
	}
	
	fixtureDef.shape = &shape;	
	body->CreateFixture(&fixtureDef);
}


- (void)dealloc {
    [super dealloc];
}


@end
