//
//  NoteBallA.m
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "NoteBall.h"
#import "ModeAViewController.h"


@implementation NoteBall

@synthesize touchJoint;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
				
		
    }
    return self;
}

- (void)setWorld:(b2World *)world {
	
	bodyDef.type = b2_dynamicBody;
	CGPoint p = self.center;
	CGRect screen = [[UIScreen mainScreen] bounds];
	bodyDef.position.Set(p.x/PTM_RATIO, (screen.size.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	body = world->CreateBody(&bodyDef);		

	b2CircleShape shape;
	shape.m_radius = self.bounds.size.width/PTM_RATIO/2.0;
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;	
	fixtureDef.density = 3.0f;
	fixtureDef.friction = 0.9f;
	fixtureDef.restitution = 0.75f; // 0 is a lead ball, 1 is a super bouncy ball
	body->CreateFixture(&fixtureDef);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	

	
	CGContextRef X = UIGraphicsGetCurrentContext();    
	
	CGContextSetAllowsAntialiasing(X, NO);
	
    CGRect bounds =  CGContextGetClipBoundingBox(X);
    CGPoint center = CGPointMake((bounds.size.width / 2), (bounds.size.height / 2));
    //NSLog(@"--> (drawRect) bounds:'%@'", NSStringFromCGRect(bounds));
    
    // black circle
    CGContextSetRGBFillColor(X, 0, 0, 0, 1.0);
    CGContextFillEllipseInRect(X, CGRectMake(0, 0, bounds.size.width, bounds.size.height));
	
	// line through the middle
	CGContextSetRGBStrokeColor(X, 255, 255, 255, 1.0);
    CGContextSetLineWidth(X, 1.0f);    
    CGContextSetLineCap(X, kCGLineCapSquare);
    CGContextBeginPath(X);
    CGContextMoveToPoint(X, center.x + 10, center.y - 10);
    CGContextAddLineToPoint(X, center.x - 10, center.y + 10);
    CGContextStrokePath(X);

}


- (void)dealloc {
    [super dealloc];
}


@end
