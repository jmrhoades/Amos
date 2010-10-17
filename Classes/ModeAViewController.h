//
//  ModeAViewController.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "ModeAContactListener.h"

@class NoteBall;

@interface ModeAViewController : UIViewController <UIAccelerometerDelegate, UIGestureRecognizerDelegate> {
	b2World* world;
	NSTimer *tickTimer;
	b2Body* groundBody;
	ModeAContactListener *contactListener;
	NoteBall *ballA;
	NoteBall *ballB;
	NoteBall *ballC;	
}

-(void) createPhysicsWorld;
-(void) addPhysicalBodyForView:(UIView *)physicalView;
-(void) tick:(NSTimer *)timer;
-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void) panBallA:(UIPanGestureRecognizer *)gestureRecognizer;
-(void) panBallB:(UIPanGestureRecognizer *)gestureRecognizer;
-(void) panBallC:(UIPanGestureRecognizer *)gestureRecognizer;
-(CGPoint) convertToGL:(CGPoint)uiPoint;

@end

