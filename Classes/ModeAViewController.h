//
//  ModeAViewController.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#define PTM_RATIO 16

#define CORNER_TOPLEFT @"CORNER_TOPLEFT"
#define CORNER_TOPRIGHT @"CORNER_TOPRIGHT"
#define CORNER_BOTLEFT @"CORNER_BOTLEFT"
#define CORNER_BOTRIGHT @"CORNER_BOTRIGHT"

#define BLOCK_TOP @"BLOCK_TOP"
#define BLOCK_RIGHT @"BLOCK_RIGHT"
#define BLOCK_LEFT @"BLOCK_LEFT"
#define BLOCK_BOT @"BLOCK_BOT"


#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "ModeAContactListener.h"
#import "libdsmi_iphone.h"

@class NoteBall;
@class ModeACorner;
@class ModeANoteBlock;

@interface ModeAViewController : UIViewController <UIAccelerometerDelegate, UIGestureRecognizerDelegate> {
	b2World *world;
	NSTimer *tickTimer;
	b2Body* groundBody;
	ModeAContactListener *contactListener;
	NoteBall *ballA;
	NoteBall *ballB;
	NoteBall *ballC;
	ModeACorner *cornerA;
	ModeACorner *cornerB;
	ModeACorner *cornerC;
	ModeACorner *cornerD;
	
	NSMutableArray *noteblocks;
	libdsmi_iphone *libdsmi;

}

-(void) createPhysicsWorld;
-(void) addPhysicalBodyForView:(UIView *)physicalView;
-(void) tick:(NSTimer *)timer;
-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void) panBallA:(UIPanGestureRecognizer *)gestureRecognizer;
-(void) panBallB:(UIPanGestureRecognizer *)gestureRecognizer;
-(void) panBallC:(UIPanGestureRecognizer *)gestureRecognizer;
-(CGPoint) convertToGL:(CGPoint)uiPoint;
-(void) addNoteBlock:(NSString *)typeName forIndex:(int)i;

@end

