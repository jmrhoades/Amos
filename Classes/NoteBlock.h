//
//  NoteBlock.h
//  Amos
//
//  Created by Justin Rhoades on 10/27/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "AmosUIViewBody.h"

@interface NoteBlock : AmosUIViewBody {
	
	UIImageView *base;
	UIImageView *baseContact;
	UIImageView *light;	
	UILabel *noteLabel;
	
	NSString *blockType;	
	int noteIndex;
	
}

@property (nonatomic, retain) UILabel *noteLabel;
@property (nonatomic) int noteIndex;


- (void) setBlockType:(NSString *)type;
- (void) setNoteValue:(int)note;
- (void) playNote:(int)note withVelocity:(int)vel;
- (void) endNote;

@end
