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
	
	UILabel *label;
	UIImageView *image;
	UIImageView *image_active;
	ModeAViewController *controller;

}

@property (nonatomic, retain) ModeAViewController *controller;


- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer;

@end
