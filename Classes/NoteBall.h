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
	b2MouseJoint* touchJoint;
}

@property (nonatomic) b2MouseJoint *touchJoint;



@end
