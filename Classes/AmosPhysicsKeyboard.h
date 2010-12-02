//
//  AmosPhysicsKeyboard.h
//  AmosUIView
//
//  Created by Justin Rhoades on 10/31/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//


#define KEYBOARD_TOP @"KEYBOARD_TOP"
#define KEYBOARD_RIGHT @"KEYBOARD_RIGHT"
#define KEYBOARD_LEFT @"KEYBOARD_LEFT"
#define KEYBOARD_BOT @"KEYBOARD_BOT"

#import <Foundation/Foundation.h>
#import <Box2D/Box2D.h>


@interface AmosPhysicsKeyboard : NSObject {
	
	b2World *world;
	b2Body *groundBody;
	
	UIView *view;
	NSString *type;
	NSMutableArray *noteBlocks;
}

@property (nonatomic, retain) NSMutableArray *noteBlocks;


-(id) initWithView:(UIView *)aView world:(b2World *)aWorld groundBody:(b2Body *)aGroundBody andType:(NSString *)aType;
-(void) update;
-(void) updateNotes;

@end
