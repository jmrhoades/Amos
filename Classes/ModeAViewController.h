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
#define DISC_LARGE @"DISC_LARGE"
#define DISC_MEDIUM @"DISC_MEDIUM"
#define DISC_SMALL @"DISC_SMALL"
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
@class AmosDisc;
@class MIDIToggleButton;


@interface ModeAViewController : UIViewController <UIAccelerometerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UIPopoverControllerDelegate> {
	b2World *world;
	NSTimer *tickTimer;
	NSTimer *midiCheckTimer;
	b2Body* groundBody;
	ModeAContactListener *contactListener;
	
	AmosDisc *discMedium;
	AmosDisc *discLarge;
	AmosDisc *discSmall;

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
	MIDIToggleButton *midiOnOffButton;
	
	UILabel *titleLabel;
	
	SettingsViewController *settingsViewController;
}


@property (nonatomic, retain) AmosDisc *discLarge;
@property (nonatomic, retain) AmosDisc *discMedium;
@property (nonatomic, retain) AmosDisc *discSmall;

@property (nonatomic, retain) MIDIToggleButton *midiOnOffButton;




-(void) createPhysicsWorld;
-(void) createEdgeWalls;
-(void) createWorldObjects;
-(void) tick:(NSTimer *)timer;
-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void) createCorners;
-(void) createKeyboards;
- (void) bpmSliderAction:(id)sender;
- (void) showSettings;
- (void) toggleMIDI;


-(void) noteSettingsDidChange;
-(void) toggleShape:(int)shapeTag status:(bool)isOn;

-(void) checkMIDI;

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController;

@end

