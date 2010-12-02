//
//  AmosUIViewBody.m
//  Amos
//
//  Created by Justin Rhoades on 10/27/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "AmosUIViewBody.h"
#import "ModeAViewController.h"


@implementation AmosUIViewBody

@synthesize touchJoint;
@synthesize keyboardJoint;
@synthesize fixture;
@synthesize body;
@synthesize mouseJointMaxForce;
@synthesize distanceJoint;
@synthesize world;
@synthesize groundBody;
@synthesize noteValue;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
        
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
		[panGesture setMaximumNumberOfTouches:2];
		[panGesture setDelegate:self];
		[self addGestureRecognizer:panGesture];
		[panGesture release];
		
		mouseJointMaxForce = 350.0f;
		
		self.noteValue = 48;
		
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer {
	
    UIView *uiView = [gestureRecognizer view];
	
	if (uiView == self) {
		CGPoint touchLocation = [gestureRecognizer locationInView:self.superview];
		CGPoint location = [self convertToGL:touchLocation];
		b2Vec2  locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);		
		if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {	
			b2MouseJointDef md;
			md.bodyA = groundBody;
			md.bodyB = body;
			md.target = locationWorld;
			md.collideConnected = true;
			md.dampingRatio = 1.0;
			md.maxForce = mouseJointMaxForce * body->GetMass();
			if (self.touchJoint != NULL) {						
				world->DestroyJoint(self.touchJoint);
				self.touchJoint = NULL;
			}
			self.touchJoint = (b2MouseJoint *)world->CreateJoint(&md);
			[self panBegan];
		}
		if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
			// NSLog(@"Moved %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
			if (self.touchJoint != NULL) {
				self.touchJoint->SetTarget(locationWorld);
			}
		}
		if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled) {
			// NSLog(@"End %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);		
			if (self.touchJoint != NULL) {
				world->DestroyJoint(self.touchJoint);
				self.touchJoint = NULL;
			}
			[self panEnded];
		}	
	}
}

- (void)panBegan {
	
}

- (void)panEnded {
	
}

- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	
}


-(CGPoint)convertToGL:(CGPoint)uiPoint
{
	CGSize s = self.superview.bounds.size;
	float newY = s.height - uiPoint.y;
	float newX = s.width - uiPoint.x;
	
	CGPoint ret = CGPointZero;
	
	
	//NSLog(@"convertToGL %@", [[UIDevice currentDevice] orientation]);
	
	
	/*
	
	switch ( [[UIDevice currentDevice] orientation] ) {
			
		case UIDeviceOrientationUnknown:
			NSLog(@"UIDeviceOrientationUnknown");
			break;
		case UIDeviceOrientationPortrait:
			NSLog(@"UIDeviceOrientationPortrait");
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			NSLog(@"UIDeviceOrientationPortraitUpsideDown");
			break;
		case UIDeviceOrientationLandscapeLeft:
			NSLog(@"UIDeviceOrientationLandscapeLeft");
			break;
		case UIDeviceOrientationLandscapeRight:
			NSLog(@"UIDeviceOrientationLandscapeRight");
			break;
		case UIDeviceOrientationFaceUp:
			NSLog(@"UIDeviceOrientationFaceUp");
			break;
		case UIDeviceOrientationFaceDown:
			NSLog(@"UIDeviceOrientationFaceDown");
			break;
	}
	
	 */
	
	

	switch ( [[UIDevice currentDevice] orientation] ) {
		
		case UIDeviceOrientationUnknown:
			ret = CGPointMake(uiPoint.x, newY);
		break;

		case UIDeviceOrientationPortrait:
			ret = CGPointMake(uiPoint.x, newY);
		break;
		case UIDeviceOrientationPortraitUpsideDown:
			ret = CGPointMake(newX, uiPoint.y);
			break;
		case UIDeviceOrientationLandscapeLeft:
			ret.x = uiPoint.y;
			ret.y = uiPoint.x;
			break;
		case UIDeviceOrientationLandscapeRight:
			ret.x = newY;
			ret.y = newX;
		break;
		case UIDeviceOrientationFaceUp:
			ret = CGPointMake(uiPoint.x, newY);
		break;
		case UIDeviceOrientationFaceDown:
			ret = CGPointMake(uiPoint.x, newY);
		break;
	}
	
	// FIXED FOR PORTRAIT
	
	ret = CGPointMake(uiPoint.x, newY);

	
	
	return ret;
}


- (void)dealloc {
    [super dealloc];
}


@end
