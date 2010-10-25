//
//  ModeACorner.h
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>


@interface ModeACorner : UIView {
	b2BodyDef bodyDef;
	b2Fixture *fixture;		
	b2Body *body;
	NSString *cornerType;
	UIImageView *background;
}

@property (nonatomic) b2Fixture *fixture;

- (void)setCornerType:(NSString *)type;
- (void)setWorld:(b2World *)world;

@end
