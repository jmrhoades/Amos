//
//  BottomBlock.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/9/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "AmosUIViewBody.h"

@class ModeAViewController;

@interface BottomBlock : AmosUIViewBody {
	UIImageView *background;
		
	UIImageView *image_off;
	UIImageView *image_on;	
	UIImageView *image_active;
	bool isOn;
	ModeAViewController *controller;

}

@property (nonatomic, retain) ModeAViewController *controller;
@property (nonatomic) bool isOn;


- (void) playNote;
- (void) toggle;
- (void) tap:(UIPanGestureRecognizer *)gestureRecognizer;



@end
