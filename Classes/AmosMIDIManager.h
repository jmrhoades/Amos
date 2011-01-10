//
//  AmosMIDIManager.h
//  Amos
//
//  Created by Justin Rhoades on 10/19/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libdsmi_iphone.h"
#import "PYMIDIManager.h"
#import "PYMIDIEndpoint.h"
#import "mmz.h"

@class ModeAViewController;


@interface AmosMIDIManager : NSObject <MZControllerDelegateProtocol> {
	libdsmi_iphone *libdsmi;

	NSMutableArray *noteSettings;
	NSArray *midiNotes;
	int noteSetting;
	NSArray *midiNoteLabels;
	NSMutableArray *midiNoteRange;
	float BPM; 
	float beatLength;
	int octaveCount;
	int octaveStart;
	
	int midiChannelUSB;
	int midiChannelWiFi;
	
	bool isMIDIOn;
	bool isMIDIMobilizerConnected;

	
	ModeAViewController *controller;
	
	PYMIDIEndpoint *midiEndPoint;

}
@property (nonatomic, retain) ModeAViewController *controller;

@property (nonatomic, retain) libdsmi_iphone *libdsmi;

@property (nonatomic) float beatLength;

@property (nonatomic, retain) NSMutableArray *noteSettings;
@property (nonatomic, retain) NSArray *midiNotes;
@property (nonatomic) int noteSetting;
@property (nonatomic, retain) NSArray *midiNoteLabels;
@property (nonatomic, retain) NSMutableArray *midiNoteRange;
@property (nonatomic, retain) PYMIDIEndpoint *midiEndPoint;

@property (nonatomic) bool isMIDIOn;
@property (nonatomic) bool isMIDIMobilizerConnected;

@property (nonatomic) int midiChannelUSB;
@property (nonatomic) int midiChannelWiFi;
@property (nonatomic) int midiChannelMIDIMobilizer;

- (void) playNote:(int)note withVelocity:(int)vel;
- (void) endNote:(int)note;

- (void) setNoteSetting:(int)settingIndex;
- (void) buildMidiNoteRange;
- (void) setBPM:(int)bpm;
- (void) stopMIDI;
- (void) toggleMIDIOn;
- (void) setOctaveCount:(int)oCount;
- (void) setOctaveStart:(int)oStart;
- (int)  getOctaveCount;
- (int)  getOctaveStart;
- (PYMIDIEndpoint*) getMIDIEndPoint;
- (void) midiSetupChanged;

// Line6 MIDIMobilizer
- (void) statusChanged;
- (void) midiInput:(MZMIDIMessage *)message;

@end
