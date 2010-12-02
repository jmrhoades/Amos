//
//  AmosPhysicsKeyboard.m
//  AmosUIView
//
//  Created by Justin Rhoades on 10/31/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <Box2D/Box2D.h>
#import "AmosPhysicsKeyboard.h"
#import "NoteBlock.h"
#import "ModeAViewController.h"

@implementation AmosPhysicsKeyboard

@synthesize noteBlocks;

-(id) initWithView:(UIView *)aView world:(b2World *)aWorld groundBody:(b2Body *)aGroundBody andType:(NSString *)aType {
	if (self = [super init]) {
		view = aView;
		world = aWorld;
		groundBody = aGroundBody;
		type = aType;
		noteBlocks = [[NSMutableArray alloc] init];

		CGSize screenSize = view.bounds.size;	
		NoteBlock *note;
		NoteBlock *prevNote;
		CGRect blockFrame;
		int x;
		int y;
		int blockWidth = 96;
		b2PrismaticJointDef prismaticJointDef;
		prismaticJointDef.collideConnected = true;
		b2Vec2 worldXAxis(1.0f, 0.0f);
		b2Vec2 worldYAxis(0.0f, 1.0f);
		b2DistanceJointDef distanceJointDef;
		
		int leftEdge = -16 - 8;
		int rightEdge = leftEdge + (96*7) + 8 + 8;
		int topEdge = 44 - 16 - 8;
		int bottomEdge = 44-16 + (96*9) + 8;
		
		if (type == KEYBOARD_TOP) {
			
			for (int i = 0; i < 6; i++) {
			
				x = -16 + blockWidth + (i*blockWidth) + 24;
				blockFrame = CGRectMake(x, topEdge, 128, 128);
				note = [[NoteBlock alloc] initWithFrame:blockFrame];
				[view addSubview:note];
				[note setWorld:world withGroundBody:groundBody];
				[note setBlockType:BLOCK_TOP];
				note.tag = i;
				[note setNoteValue:i];
				
				// Connect to top wall
				prismaticJointDef.Initialize(note.body, groundBody, note.body->GetWorldCenter(), worldXAxis);
				world->CreateJoint(&prismaticJointDef);
				if (i > 0) {
					distanceJointDef.Initialize(note.body, prevNote.body, note.body->GetWorldCenter(), prevNote.body->GetWorldCenter());
					note.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&distanceJointDef);
				}
				prevNote = note;
				
				[noteBlocks addObject:note];
			}
		}
		
		if (type == KEYBOARD_BOT) {
			
			for (int i = 0; i < 6; i++) {
				
				x = -16 + blockWidth + (i*blockWidth) + 24;
				blockFrame = CGRectMake(x, bottomEdge, 128, 128);
				note = [[NoteBlock alloc] initWithFrame:blockFrame];
				[view addSubview:note];
				[note setWorld:world withGroundBody:groundBody];
				[note setBlockType:BLOCK_BOT];
				note.tag = i;
				[note setNoteValue:i];
				
				// Connect to top wall
				prismaticJointDef.Initialize(note.body, groundBody, note.body->GetWorldCenter(), worldXAxis);
				world->CreateJoint(&prismaticJointDef);
				if (i > 0) {
					distanceJointDef.Initialize(note.body, prevNote.body, note.body->GetWorldCenter(), prevNote.body->GetWorldCenter());
					note.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&distanceJointDef);
				}
				prevNote = note;
				
				[noteBlocks addObject:note];
			}
		}
		
		if (type == KEYBOARD_LEFT) {
		
			for (int i = 0; i < 6; i++) {
				
				y = (44-16+96+(blockWidth*1)) + (i*blockWidth) + 24;
				blockFrame = CGRectMake(leftEdge, y, 128, 128);
				note = [[NoteBlock alloc] initWithFrame:blockFrame];
				[view addSubview:note];
				[note setWorld:world withGroundBody:groundBody];
				[note setBlockType:BLOCK_LEFT];
				note.tag = i;
				[note setNoteValue:i];
				
				// Connect to top wall
				prismaticJointDef.Initialize(note.body, groundBody, note.body->GetWorldCenter(), worldYAxis);
				world->CreateJoint(&prismaticJointDef);
				[noteBlocks addObject:note];
			}
			
			for (int i = 0; i < [noteBlocks count]-1; i++) {
				NoteBlock *note = [noteBlocks objectAtIndex:i];
				NoteBlock *noteNext = [noteBlocks objectAtIndex:i+1];
				distanceJointDef.Initialize(note.body, noteNext.body, note.body->GetWorldCenter(), noteNext.body->GetWorldCenter());
				note.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&distanceJointDef);
			}
			
			
		}
		
		if (type == KEYBOARD_RIGHT) {
			
			for (int i = 0; i < 6; i++) {
				
				y = (44-16+96+(blockWidth*1)) + (i*blockWidth) + 24;
				blockFrame = CGRectMake(rightEdge, y, 128, 128);
				note = [[NoteBlock alloc] initWithFrame:blockFrame];
				[view addSubview:note];
				[note setWorld:world withGroundBody:groundBody];
				[note setBlockType:BLOCK_RIGHT];
				note.tag = i;
				[note setNoteValue:i];
				
				// Connect to top wall
				prismaticJointDef.Initialize(note.body, groundBody, note.body->GetWorldCenter(), worldYAxis);
				world->CreateJoint(&prismaticJointDef);
				[noteBlocks addObject:note];
			}
			
			for (int i = 0; i < [noteBlocks count]-1; i++) {
				NoteBlock *note = [noteBlocks objectAtIndex:i];
				NoteBlock *noteNext = [noteBlocks objectAtIndex:i+1];
				distanceJointDef.Initialize(note.body, noteNext.body, note.body->GetWorldCenter(), noteNext.body->GetWorldCenter());
				note.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&distanceJointDef);
			}
			
			
		}

		
		
	}
	return self;
}

-(void) update {
	
	CGSize screenSize = view.bounds.size;
	NoteBlock *overBlock;
	NoteBlock *prevBlock;
	b2Vec2 new_pos;
	b2Vec2 prev_center;	
	b2DistanceJointDef jointDef;
	
	int leftEdge = -16 + 96 - 8 + 24;
	int rightEdge = leftEdge + ([noteBlocks count] * 96) + 8 + 8;
	int topEdge = 44-16+(96*2) - 8 + 24;
	int bottomEdge = topEdge + ([noteBlocks count] * 96) + 8;

	
	if (type == KEYBOARD_BOT || type == KEYBOARD_TOP) {
		
		bool blockIsOverRightEdge = NO;
		bool blockIsOverLeftEdge = NO;
		
		for (NoteBlock *block in noteBlocks) {
			
			//NSLog(@"Block %i %f %f", block.tag, block.center.x, block.center.y);		
			
			if (block.center.x < leftEdge ) {
			
				blockIsOverLeftEdge = YES;
				overBlock = block;
				prevBlock = [noteBlocks lastObject];
			
				// Destroy the previous block's joint
				if (overBlock.distanceJoint != NULL) {						
					world->DestroyJoint(overBlock.distanceJoint);
					overBlock.distanceJoint = NULL;
				}
				
				prev_center = prevBlock.body->GetWorldCenter();
				new_pos.Set( prev_center.x + (96/PTM_RATIO), prev_center.y);
				overBlock.body->SetTransform(new_pos, 0);
			
				// Create joint that links old block to new block
				jointDef.Initialize(overBlock.body, prevBlock.body, overBlock.body->GetWorldCenter(), prevBlock.body->GetWorldCenter());
				overBlock.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&jointDef);
				
				
				
				break;			
			}
		
			if (block.center.x > rightEdge) {
			
				blockIsOverRightEdge = YES;
				overBlock = block;
				prevBlock = [noteBlocks objectAtIndex:0];
			
				// Destroy the previous block's joint
				if (prevBlock.distanceJoint != NULL) {						
					world->DestroyJoint(prevBlock.distanceJoint);
					prevBlock.distanceJoint = NULL;
				}
			
				prev_center = prevBlock.body->GetWorldCenter();
				new_pos.Set( prev_center.x - (96/PTM_RATIO), prev_center.y);
				overBlock.body->SetTransform(new_pos, 0);
			
			
				// Create joint that links old block to new block
				jointDef.Initialize(overBlock.body, prevBlock.body, overBlock.body->GetWorldCenter(), prevBlock.body->GetWorldCenter());
				prevBlock.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&jointDef);
			
				break;			
			}
			
		}
		
		if (blockIsOverLeftEdge) {
			[noteBlocks removeObject:overBlock];
			[noteBlocks addObject:overBlock];
			blockIsOverLeftEdge = NO;
			[overBlock setNoteValue:prevBlock.noteIndex+1];
		}
		
		if (blockIsOverRightEdge) {
			[noteBlocks removeObject:overBlock];
			[noteBlocks insertObject:overBlock atIndex:0];
			blockIsOverRightEdge = NO;
			[overBlock setNoteValue:prevBlock.noteIndex-1];
		}
		
		return;
		
	}
	
	if (type == KEYBOARD_LEFT || type == KEYBOARD_RIGHT) {
		bool blockIsOverTopEdge = NO;		
		bool blockIsOverBottomEdge = NO;
			
		for (NoteBlock *block in noteBlocks) {
		
			if (block.center.y < topEdge ) {
				
				//NSLog(@"OVER");
				//NSLog(@"Tag: %i y:%f topEdge:%i", block.tag, block.center.y, topEdge);
				
				blockIsOverTopEdge = YES;
				overBlock = block;
				prevBlock = [noteBlocks lastObject];
				//NSLog(@"prevBlock: %f %f", prevBlock.center.x, prevBlock.center.y);

				// Destroy the current block's joint
				if (overBlock.distanceJoint != NULL) {
					//NSLog(@"-DestroyJoint");
					world->DestroyJoint(overBlock.distanceJoint);
					overBlock.distanceJoint = NULL;
				}
				
				prev_center = prevBlock.body->GetWorldCenter();
				new_pos.Set( prev_center.x, prev_center.y - 6);
				overBlock.body->SetTransform(new_pos, 0);
				//NSLog(@"new_pos: %f %f", new_pos.x*PTM_RATIO, new_pos.y*PTM_RATIO);
				//NSLog(@"-------------------------------------------------------------------");
				
				// Create joint that links old block to new block
				jointDef.Initialize(prevBlock.body, overBlock.body, prevBlock.body->GetWorldCenter(), overBlock.body->GetWorldCenter());
				overBlock.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&jointDef);
				
				break;			
			}
			
			if (block.center.y > bottomEdge ) {
				
				//NSLog(@"UNDER");
				//NSLog(@"Tag: %i y:%f topEdge:%i", block.tag, block.center.y, topEdge);
				
				blockIsOverBottomEdge = YES;
				overBlock = block;
				prevBlock = [noteBlocks objectAtIndex:0];
				//NSLog(@"prevBlock: %f %f", prevBlock.center.x, prevBlock.center.y);
				
				// Destroy the current block's joint
				if (overBlock.distanceJoint != NULL) {
					world->DestroyJoint(overBlock.distanceJoint);
					overBlock.distanceJoint = NULL;
				}
				
				prev_center = prevBlock.body->GetWorldCenter();
				new_pos.Set( prev_center.x, prev_center.y + 6);
				overBlock.body->SetTransform(new_pos, 0);
				//NSLog(@"new_pos: %f %f", new_pos.x*PTM_RATIO, new_pos.y*PTM_RATIO);
				//NSLog(@"-------------------------------------------------------------------");
				
				// Create joint that links old block to new block
				jointDef.Initialize(prevBlock.body, overBlock.body, prevBlock.body->GetWorldCenter(), overBlock.body->GetWorldCenter());
				overBlock.distanceJoint = (b2DistanceJoint *)world->CreateJoint(&jointDef);
				
				break;			
			}
		}
		
		if (blockIsOverTopEdge) {
			[noteBlocks removeObject:overBlock];
			[noteBlocks addObject:overBlock];
			blockIsOverTopEdge = NO;
			[overBlock setNoteValue:prevBlock.noteIndex-1];			
		}
		
		if (blockIsOverBottomEdge) {
			[noteBlocks removeObject:overBlock];
			[noteBlocks insertObject:overBlock atIndex:0];
			blockIsOverBottomEdge = NO;
			[overBlock setNoteValue:prevBlock.noteIndex+1];			
		}
			
	
	}
	
}


-(void) updateNotes {

	for (int i = 0; i < [noteBlocks count]-1; i++) {
		NoteBlock *note = [noteBlocks objectAtIndex:i];
		[note setNoteValue:i];
	}
	
}



@end
