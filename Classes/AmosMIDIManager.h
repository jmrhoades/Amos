//
//  AmosMIDIManager.h
//  Amos
//
//  Created by Justin Rhoades on 10/19/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libdsmi_iphone.h"

@class ModeAViewController;


@interface AmosMIDIManager : NSObject {
	libdsmi_iphone *libdsmi;

	NSMutableArray *noteSettings;
	NSArray *midiNotes;
	int noteSetting;
	NSArray *midiNoteLabels;
	NSMutableArray *midiNoteRange;
	float BPM; 
	float beatLength;
	
	bool isMIDIOn;
	
	ModeAViewController *controller;

}
@property (nonatomic, retain) ModeAViewController *controller;

@property (nonatomic, retain) libdsmi_iphone *libdsmi;

@property (nonatomic) float beatLength;

@property (nonatomic, retain) NSMutableArray *noteSettings;
@property (nonatomic, retain) NSArray *midiNotes;
@property (nonatomic) int noteSetting;
@property (nonatomic, retain) NSArray *midiNoteLabels;
@property (nonatomic, retain) NSMutableArray *midiNoteRange;

@property (nonatomic) bool isMIDIOn;


- (void) playNote:(int)note withVelocity:(int)vel;
- (void) endNote:(int)note;

- (void) stopNoteByTimer:(NSTimer*)theTimer;
- (void) setNoteSetting:(int)settingIndex;
- (void) buildMidiNoteRange;
- (void) setBPM:(int)bpm;
- (void) stopMIDI;
- (void) toggleMIDIOn;

@end
