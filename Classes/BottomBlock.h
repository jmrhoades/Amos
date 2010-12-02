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

@interface BottomBlock : AmosUIViewBody {
	UIImageView *background;
	UIImageView *up;
	UIImageView *up_on;

}

- (void) playNote;


@end
