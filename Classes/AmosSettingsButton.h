//
//  AmosSetNotesButton.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/1/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModeAViewController;

@interface AmosSettingsButton : UIView <UIGestureRecognizerDelegate> {
	
	UIImageView *image_off;
	UIImageView *image_on;	
	UIImageView *image_active;
	bool isOn;
	ModeAViewController *controller;

}

@property (nonatomic, retain) ModeAViewController *controller;

- (void) toggle;
- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer;

@end
