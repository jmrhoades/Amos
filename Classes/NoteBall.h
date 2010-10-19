//
//  NoteBallA.h
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>


@interface NoteBall : UIView {
	b2MouseJoint *touchJoint;
	b2Fixture *fixture;	
	b2BodyDef bodyDef;
	b2Body *body;
}

@property (nonatomic) b2MouseJoint *touchJoint;
@property (nonatomic) b2Fixture *fixture;

- (void)setWorld:(b2World *)world;



@end
