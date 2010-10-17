//
//  AmosAppDelegate.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AmosViewController;

@interface AmosAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AmosViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AmosViewController *viewController;

@end

