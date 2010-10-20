//
//  ModeANoteBlock.m
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "ModeANoteBlock.h"
#import "ModeAViewController.h"
#import "AmosAppDelegate.h"

@implementation ModeANoteBlock

@synthesize fixture;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		
		/*
		 Create a tap recognizer and add it to the view.
		 Keep a reference to the recognizer to test in gestureRecognizer:shouldReceiveTouch:.
		 */
		tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
		[self addGestureRecognizer:tapRecognizer];
		tapRecognizer.delegate = self;
		
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
	
	if ([blockType isEqualToString:BLOCK_TOP] || [blockType isEqualToString:BLOCK_BOT]) {
		CGContextSetRGBFillColor(X, 0, 0, 0, 1.0);
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 64.0, 96.0));
		
		CGContextSetRGBFillColor(X, .25,.25,.25, 1.0);
		CGContextFillRect(X, CGRectMake(63.0, 0.0, 1.0, 96.0));
	}
	
	if ([blockType isEqualToString:BLOCK_RIGHT] || [blockType isEqualToString:BLOCK_LEFT]) {
		CGContextSetRGBFillColor(X, 0, 0, 0, 1.0);
		CGContextFillRect(X, CGRectMake(0.0, 0.0, 96.0, 64.0));
		
		CGContextSetRGBFillColor(X, .25,.25,.25, 1.0);
		CGContextFillRect(X, CGRectMake(0.0, 63.0, 96.0, 1.0));
	}
	
}

- (void)playNote:(int)note withVelocity:(int)vel {

	//NSLog(@"Note block hit Hit!");

	[UIView animateWithDuration:.01
			delay:0
			options:UIViewAnimationOptionAllowUserInteraction
			animations:^{ 
				self.alpha = 0;
			}
			completion:^(BOOL finished){
	[UIView animateWithDuration:.33
			delay:0
			options:UIViewAnimationOptionAllowUserInteraction
			animations:^{
				self.alpha = 1;
			}
			completion:^(BOOL finished){
				;
			}
	];}];
	
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager playNote:note withVelocity:vel];
	
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    
    //CGPoint location = [recognizer locationInView:self.view];
    
    [self playNote:0 withVelocity:64];
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
	fixture = body->CreateFixture(&fixtureDef);
}


- (void)dealloc {
    [super dealloc];
}


@end
