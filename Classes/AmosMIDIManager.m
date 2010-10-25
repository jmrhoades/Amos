//
//  AmosMIDIManager.m
//  Amos
//
//  Created by Justin Rhoades on 10/19/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "AmosMIDIManager.h"

@implementation AmosMIDIManager

@synthesize libdsmi;
@synthesize midiNoteNamesMap;


-(id) init {
	if (self = [super init]) {
		
		// ***  Initialize DSMI
		//**********************
		libdsmi = [[libdsmi_iphone alloc] init];
		// ***************
		
		
		midiNoteNamesMap = [NSArray arrayWithObjects:@"C-1",@"C#-1",@"D-1",@"D#-1",@"E-1",@"F-1",@"F#-1",@"G-1",@"G#-1",@"A-1",@"A#-1",@"B-1",nil];

		
	}
	return self;
}


- (void)playNote:(int)note withVelocity:(int)vel {
	NSLog(@"AmosMIDIManager: Play note.");

	[libdsmi writeMIDIMessage:NOTE_ON MIDIChannel:0 withData1:48 withData2:vel];
	
	NSNumber *tNote = [NSNumber numberWithInt:note];

	NSDictionary *userInfo =  [NSDictionary dictionaryWithObject:tNote forKey:@"note"];
		
	[NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(stopNoteByTimer:) userInfo:userInfo repeats:NO];

}

- (void)stopNoteByTimer:(NSTimer*)theTimer  {
	NSLog(@"AmosMIDIManager: stopNoteByTimer.");
	
	NSNumber *note = [[theTimer userInfo] objectForKey:@"note"];
	
	[libdsmi writeMIDIMessage:NOTE_OFF MIDIChannel:0 withData1:[note intValue] withData2:30];
		
}


@end
