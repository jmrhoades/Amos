//
//  AmosAppDelegate.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModeAViewController;

@interface AmosAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ModeAViewController *modeA;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ModeAViewController *modeA;

@end

