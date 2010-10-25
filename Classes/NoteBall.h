//
//  NoteBallA.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>


@interface NoteBall : UIView <UIGestureRecognizerDelegate> {
	b2World *world;
	b2MouseJoint *touchJoint;
	b2Fixture *fixture;	
	b2BodyDef bodyDef;
	b2Body *body;
	b2Body *groundBody;	
	UIImageView *base;
	UIImageView *outerRing;
	UIImageView *outerRingPanning;
	UIImageView *innerRing;
	UIImageView *innerRingContact;
	UIImageView *centerDisc;
	UIImageView *note;		
	UIImageView *shine;	
}

@property (nonatomic) b2MouseJoint *touchJoint;
@property (nonatomic) b2Fixture *fixture;

- (void)setWorld:(b2World *)world withGroundBody:(b2Body *)aGroundBody;

-(void) pan:(UIPanGestureRecognizer *)gestureRecognizer;
-(CGPoint) convertToGL:(CGPoint)uiPoint;
- (void)playNote:(int)note withVelocity:(int)vel;

@end
