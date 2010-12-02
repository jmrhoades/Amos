//
//  AmosUIViewBody.h
//  Amos
//
//  Created by Justin Rhoades on 10/27/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>

@interface AmosUIViewBody : UIView <UIGestureRecognizerDelegate> {
	
	b2World *world;
	b2Body *groundBody;
	b2Body *body;
	b2Fixture *fixture;		
	b2MouseJoint *touchJoint;
	b2PrismaticJoint *keyboardJoint;
	b2DistanceJoint *distanceJoint;
	float mouseJointMaxForce;
	int noteValue;	
}

@property (nonatomic) b2World *world;
@property (nonatomic) b2Body *groundBody;
@property (nonatomic) b2Body *body;
@property (nonatomic) b2Fixture *fixture;
@property (nonatomic) b2MouseJoint *touchJoint;
@property (nonatomic) b2PrismaticJoint *keyboardJoint;
@property (nonatomic) b2DistanceJoint *distanceJoint;
@property (nonatomic) float mouseJointMaxForce;
@property (nonatomic) int noteValue;


-(void) setWorld:(b2World *)world withGroundBody:(b2Body *)aGroundBody;
-(void) pan:(UIPanGestureRecognizer *)gestureRecognizer;
-(CGPoint) convertToGL:(CGPoint)uiPoint;
-(void) panBegan;
-(void) panEnded;

@end
