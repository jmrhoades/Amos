//
//  ModeANoteBlock.h
//  Amos
//
//  Created by Justin Rhoades on 10/17/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>

@interface ModeANoteBlock : UIView <UIGestureRecognizerDelegate> {
	b2World *world;
	b2Body *groundBody;	

	b2BodyDef bodyDef;
	b2Body *body;
	NSString *blockType;
	b2Fixture *fixture;	
    UITapGestureRecognizer *tapRecognizer;
	
	UIImageView *base;
	UIImageView *baseContact;
	UIImageView *light;
	
	UILabel *noteLabel;
	int noteValue;
}

@property (nonatomic) b2Fixture *fixture;

- (void)setBlockType:(NSString *)type;
- (void)setWorld:(b2World *)world withGroundBody:(b2Body *)aGroundBody;
- (void)playNote:(int)note withVelocity:(int)vel;
- (void) setNoteValue:(int)note;

@end
