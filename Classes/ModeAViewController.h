//
//  ModeAViewController.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>

@class NoteBallA;


@interface ModeAViewController : UIViewController {
	b2World* world;
	NSTimer *tickTimer;
	b2Body* groundBody;
	
	NoteBallA *ballA;
}

-(void)createPhysicsWorld;
-(void)addPhysicalBodyForView:(UIView *)physicalView;
-(void) tick:(NSTimer *)timer;
@end

