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

#define CIRCLE_WHOLE_NOTE @"CIRCLE_WHOLE_NOTE"
#define CIRCLE_HALF_NOTE @"CIRCLE_HALF_NOTE"
#define CIRCLE_QUARTER_NOTE @"CIRCLE_QUARTER_NOTE"
#define CIRCLE_EIGHTH_NOTE @"CIRCLE_EIGHTH_NOTE"
#define CIRCLE_SIXTEENTH_NOTE @"CIRCLE_SIXTEENTH_NOTE"

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "ModeAContactListener.h"

@class ModeACorner;
@class NoteBlock;
@class AmosPhysicsKeyboard;
@class AmosSettingsButton;
@class SettingsViewController;
@class BottomBlock;

@class ShapeCircle;


@interface ModeAViewController : UIViewController <UIAccelerometerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UIPopoverControllerDelegate> {
	b2World *world;
	NSTimer *tickTimer;
	b2Body* groundBody;
	ModeAContactListener *contactListener;
	
	ShapeCircle *circleQuarterNote;
	ShapeCircle *circleWholeNote;
	ShapeCircle *circleSixteenthNote;
	ShapeCircle *circleHalfNote;
	ShapeCircle *circleEighthNote;

	ModeACorner *cornerA;
	ModeACorner *cornerB;
	ModeACorner *cornerC;
	ModeACorner *cornerD;
	
	BottomBlock *bottomBlock;
	
	NSMutableArray *noteBlocks;
	NSMutableArray *topKeyboardBlocks;

	AmosPhysicsKeyboard *keyboardTop;
	AmosPhysicsKeyboard *keyboardBot;
	AmosPhysicsKeyboard *keyboardLeft;
	AmosPhysicsKeyboard *keyboardRight;	
	
	UISlider *bpmSlider;
	UILabel *bpmLabel;
	AmosSettingsButton *settingsButton;
	UILabel *titleLabel;
	
	SettingsViewController *settingsViewController;
}



@property (nonatomic, retain) ShapeCircle *circleQuarterNote;
@property (nonatomic, retain) ShapeCircle *circleWholeNote;
@property (nonatomic, retain) ShapeCircle *circleSixteenthNote;
@property (nonatomic, retain) ShapeCircle *circleHalfNote;
@property (nonatomic, retain) ShapeCircle *circleEighthNote;





-(void) createPhysicsWorld;
-(void) createEdgeWalls;
-(void) createWorldObjects;
-(void) tick:(NSTimer *)timer;
-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void) createCorners;
-(void) createKeyboards;
- (void) bpmSliderAction:(id)sender;
- (void) showSettings;

-(void) noteSettingsDidChange;
-(void) toggleShape:(int)shapeTag status:(bool)isOn;



- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController;

@end

