//
//  MIDIToggleButton.h
//  Amos
//
//  Created by Justin Rhoades on 12/5/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModeAViewController;


@interface MIDIToggleButton : UIView <UIGestureRecognizerDelegate> {
	
	UIImageView *image_off;
	UIImageView *image_on;	
	UIImageView *image_active;
	ModeAViewController *controller;
	bool isOn;
}

@property (nonatomic, retain) ModeAViewController *controller;
@property (nonatomic) bool isOn;

- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer;
- (void) toggle;
- (void) playNote;

@end
