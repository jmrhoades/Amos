//
//  NoteBallA.m
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "NoteBall.h"


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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	CGContextRef X = UIGraphicsGetCurrentContext();    
    CGRect bounds =  CGContextGetClipBoundingBox(X);
    CGPoint center = CGPointMake((bounds.size.width / 2), (bounds.size.height / 2));
    //NSLog(@"--> (drawRect) bounds:'%@'", NSStringFromCGRect(bounds));
    
    // black circle
    CGContextSetRGBFillColor(X, 0, 0, 0, 1.0);
    CGContextFillEllipseInRect(X, CGRectMake(0, 0, bounds.size.width, bounds.size.height));
	
	// line through the middle
	CGContextSetRGBStrokeColor(X, 255, 255, 255, 1.0);
    CGContextSetLineWidth(X, 1);    
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
