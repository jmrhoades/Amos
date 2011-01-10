//
//  AmosMIDIManager.m
//  Amos
//
//  Created by Justin Rhoades on 10/19/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "AmosMIDIManager.h"
#import "NoteSetting.h"
#import "ModeAViewController.h"
#import "MIDIToggleButton.h"
#import "PYMIDIManager.h"
#import "PYMIDIEndpoint.h"
#import "mmz.h"


@implementation AmosMIDIManager

@synthesize controller;
@synthesize libdsmi;
@synthesize noteSettings;
@synthesize midiNotes;
@synthesize noteSetting;
@synthesize midiNoteLabels;
@synthesize midiNoteRange;
@synthesize beatLength;
@synthesize isMIDIOn;
@synthesize midiChannelUSB;
@synthesize midiChannelWiFi;
@synthesize midiEndPoint;
@synthesize midiChannelMIDIMobilizer;
@synthesize isMIDIMobilizerConnected;

-(id) init {
	if (self = [super init]) {
		
		// ***  Initialize DSMI
		//**********************
		libdsmi = [[libdsmi_iphone alloc] init];
		// ***************
		
		//NSArray *midiNoteLabels = [NSArray arrayWithObjects:@"C",@"C#",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",@"A",@"A#",@"B",nil];
		midiNoteLabels = [NSArray arrayWithObjects:@"C-2",@"C#-2",@"D-2",@"D#-2",@"E-2",@"F-2",@"F#-2",@"G-2",@"G#-2",@"A-2",@"A#-2",@"B-2",@"C-1",@"C#-1",@"D-1",@"D#-1",@"E-1",@"F-1",@"F#-1",@"G-1",@"G#-1",@"A-1",@"A#-1",@"B-1",@"C-0",@"C#-0",@"D-0",@"D#-0",@"E-0",@"F-0",@"F#-0",@"G-0",@"G#-0",@"A-0",@"A#-0",@"B-0",@"C1",@"C#1",@"D1",@"D#1",@"E1",@"F1",@"F#1",@"G1",@"G#1",@"A1",@"A#1",@"B1",@"C2",@"C#2",@"D2",@"D#2",@"E2",@"F2",@"F#2",@"G2",@"G#2",@"A2",@"A#2",@"B2",@"C3",@"C#3",@"D3",@"D#3",@"E3",@"F3",@"F#3",@"G3",@"G#3",@"A3",@"A#3",@"B3",@"C4",@"C#4",@"D4",@"D#4",@"E4",@"F4",@"F#4",@"G4",@"G#4",@"A4",@"A#4",@"B4",@"C5",@"C#5",@"D5",@"D#5",@"E5",@"F5",@"F#5",@"G5",@"G#5",@"A5",@"A#5",@"B5",@"C6",@"C#6",@"D6",@"D#6",@"E6",@"F6",@"F#6",@"G6",@"G#6",@"A6",@"A#6",@"B6",@"C7",@"C#7",@"D7",@"D#7",@"E7",@"F7",@"F#7",@"G7",@"G#7",@"A7",@"A#7",@"B7",@"C8",@"C#8",@"D8",@"D#8",@"E8",@"F8",@"F#8",@"G8",nil];
		[midiNoteLabels retain];
		 
		midiNotes = [NSArray arrayWithObjects:@"C",@"C#",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",@"A",@"A#",@"B",nil];
		[midiNotes retain];

		noteSettings = [[NSMutableArray alloc] init];		
		NoteSetting *setting;
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"C";
		setting.value = 0;
		setting.isOn = YES;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"C#";
		setting.value = 1;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"D";
		setting.value = 2;
		setting.isOn = YES;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"D#";
		setting.value = 3;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"E";
		setting.value = 4;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"F";
		setting.value = 5;
		setting.isOn = YES;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"F#";
		setting.value = 6;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"G";
		setting.value = 7;
		setting.isOn = YES;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"G#";
		setting.value = 8;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"A";
		setting.value = 9;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"A#";
		setting.value = 10;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		setting = [[NoteSetting alloc] init];
		setting.label = @"B";
		setting.value = 11;
		setting.isOn = NO;
		[noteSettings addObject:setting];
		
		[noteSettings retain];
		
		[self setBPM:120];
		
		self.isMIDIOn = YES;
		
		self.midiChannelUSB = 0;
		self.midiChannelWiFi = 0;
		self.midiChannelMIDIMobilizer = 0;
		self.isMIDIMobilizerConnected = NO;
				
		octaveCount = 2;
		octaveStart = 4;
		
		[self buildMidiNoteRange];
		
		[self getMIDIEndPoint];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiSetupChanged) name:@"PYMIDISetupChanged" object:nil];
		
		
		//
		// Line6 MIDIMobilizer 
		//
		
		[MZController startupWithDelegate:self];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged) name:@"MZMIDIMobilizerDidConnect" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged) name:@"MZMIDIMobilizerDidDisconnect" object:nil];
		
	}
	
		
	//PYMIDIManager*  manager = [PYMIDIManager sharedInstance];
    //NSArray* endpointArray = [manager realSources];
    //NSEnumerator* enumerator = [endpointArray objectEnumerator];
    //PYMIDIEndpoint* endpoint;
    //while (endpoint = [enumerator nextObject]) {
        //[myPopUp addItemWithTitle:[endpoint displayName]];
        //[[myPopUp lastItem] setRepresentedObject:endpoint];
    //}
	 
	
	return self;
}


- (void)statusChanged
{
	self.isMIDIMobilizerConnected = [[MZController sharedController] isHardwareConnected];
	
	//[statusLabel setText:(isConnected ? @"Connected" : @"Not Connected")];
	//[sendC3Button setEnabled:isConnected];
}

- (void)midiInput:(MZMIDIMessage *)message
{
	//[inputLabel setText:[message logDescription]];
}




-(void) midiSetupChanged {
	self.midiEndPoint = [self getMIDIEndPoint];
}


- (void)playNote:(int)note withVelocity:(int)vel {
	
	if (self.isMIDIOn) {
	
		//NSLog(@"AmosMIDIManager: Play note. %i %i", note, vel);
		
		[libdsmi writeMIDIMessage:NOTE_ON MIDIChannel:midiChannelWiFi withData1:note withData2:vel];
		
		[controller.midiOnOffButton playNote];
		
		//NSNumber *tNote = [NSNumber numberWithInt:note];
		
		//NSDictionary *userInfo =  [NSDictionary dictionaryWithObject:tNote forKey:@"note"];
		
		//[NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(stopNoteByTimer:) userInfo:userInfo repeats:NO];
		
		
		if (self.midiEndPoint != nil) {
			
			[self.midiEndPoint addSender:self];
			
			MIDIPacketList packetList;
			
			packetList.numPackets = 1;
			
			MIDIPacket* firstPacket = &packetList.packet[0];
			
			firstPacket->timeStamp = 0;	// send immediately
			
			firstPacket->length = 3;
			
			firstPacket->data[0] = NOTE_ON | midiChannelUSB;
			
			firstPacket->data[1] = note;
			
			firstPacket->data[2] = vel;
			
			[self.midiEndPoint processMIDIPacketList:&packetList sender:self];
			
			[self.midiEndPoint removeSender:self];
		}
		
		if ( self.isMIDIMobilizerConnected ) {
		
			MZMIDINoteOnMessage *noteOn = [MZMIDINoteOnMessage message];
			
			[noteOn setTimestamp:0]; // don't really NEED to do this, but we're doing it for symmetry
			[noteOn setChannel:midiChannelMIDIMobilizer]; // remember, channels are NOT 0-based, they are READABLE-based
			[noteOn setNote:note]; // 60 = C3
			[noteOn setVelocity:vel];
			
			// we need to reset the clock so that the note on message acts as the start of
			// a new stream of messages. any messages with timestamps > 0 are going to be (and SHOULD be)
			// in relation to the "first" message sent after the resetClock method is called.
			// NOTE: the first message delivered after a resetClock message MUST have a timestamp of 0
			[[MZController sharedController] resetClock];
			[[MZController sharedController] sendMessages:[NSArray arrayWithObjects:noteOn, nil]];
		
		}
		
		
	}
	
}

- (void)endNote:(int)note {
	
	if (self.isMIDIOn) {

		[libdsmi writeMIDIMessage:NOTE_OFF MIDIChannel:midiChannelWiFi withData1:note withData2:0];

		
		if (self.midiEndPoint != nil) {
			
			[self.midiEndPoint addSender:self];
			
			MIDIPacketList packetList;
			
			packetList.numPackets = 1;
			
			MIDIPacket* firstPacket = &packetList.packet[0];
			
			firstPacket->timeStamp = 0;	// send immediately
			
			firstPacket->length = 3;
			
			firstPacket->data[0] = NOTE_OFF | midiChannelUSB;
			
			firstPacket->data[1] = note;
			
			firstPacket->data[2] = 0;
			
			[self.midiEndPoint processMIDIPacketList:&packetList sender:self];
			
			[self.midiEndPoint removeSender:self];
		}
		
		
		if ( self.isMIDIMobilizerConnected ) {
			
			
			MZMIDINoteOffMessage *noteOff = [MZMIDINoteOffMessage message];
			
			[noteOff setTimestamp:0]; // == 1 second after the note on - the "first" message
			[noteOff setChannel:midiChannelMIDIMobilizer];
			[noteOff setNote:note];
			
			// we need to reset the clock so that the note on message acts as the start of
			// a new stream of messages. any messages with timestamps > 0 are going to be (and SHOULD be)
			// in relation to the "first" message sent after the resetClock method is called.
			// NOTE: the first message delivered after a resetClock message MUST have a timestamp of 0
			[[MZController sharedController] resetClock];
			[[MZController sharedController] sendMessages:[NSArray arrayWithObjects:noteOff, nil]];
			
		}
	
	}
	
	
	
	
	
}


- (void)setNoteSetting:(int)settingIndex {
	noteSetting = settingIndex;
	[self buildMidiNoteRange];
}

- (void)buildMidiNoteRange {
	
	NSMutableArray *baseNotes = [[NSMutableArray alloc] init];
	
	for (NoteSetting *setting in noteSettings) {
		if (setting.isOn) {
			[baseNotes addObject:setting];
		}
	}
	
	
	midiNoteRange = [[NSMutableArray alloc] init];
	for (int i = 0; i < octaveCount; i++) {
		
		for (NoteSetting *setting in baseNotes) {
			
			NoteSetting *note = [[NoteSetting alloc] init];
			note.value = setting.value + ((octaveStart+i)*12);
			note.label =  [NSString stringWithFormat:@"%@%i", setting.label, octaveStart + i];
			[midiNoteRange addObject:note];
			
			//NSLog(@"%@ %i", note.label, note.value);

		}
	}
	[midiNoteRange retain];
	
}

- (void)setBPM:(int)bpm {
	self.beatLength = 60000/bpm;
	
	//NSLog(@"beatLength %f", beatLength);

}

- (void)stopMIDI {
	
	// Send off messages to every note
	for (int i = 0; i < 127; i++) {
		
		[libdsmi writeMIDIMessage:NOTE_OFF MIDIChannel:0 withData1:i withData2:0];
		
		if (self.midiEndPoint != nil) {
			
			[self.midiEndPoint addSender:self];
			
			MIDIPacketList packetList;
			
			packetList.numPackets = 1;
			
			MIDIPacket* firstPacket = &packetList.packet[0];
			
			firstPacket->timeStamp = 0;	// send immediately
			
			firstPacket->length = 3;
			
			firstPacket->data[0] = NOTE_OFF | midiChannelUSB;
			
			firstPacket->data[1] = i;
			
			firstPacket->data[2] = 0;
			
			[self.midiEndPoint processMIDIPacketList:&packetList sender:self];
			
			[self.midiEndPoint removeSender:self];
		}
		
		if ( self.isMIDIMobilizerConnected ) {
			
			[[MZController sharedController] stop];
			
		}
		
	}
	
}

- (void) toggleMIDIOn {
	
	self.isMIDIOn = !self.isMIDIOn;	
	[self stopMIDI];
	
}

- (void) setOctaveCount:(int)oCount {
	octaveCount = oCount;
}

- (void) setOctaveStart:(int)oStart {
	octaveStart = oStart;
}

- (int) getOctaveCount {
	return octaveCount;
}

- (int) getOctaveStart {
	return octaveStart;
}


- (PYMIDIEndpoint*) getMIDIEndPoint {
	
	PYMIDIManager*  manager = [PYMIDIManager sharedInstance];
	NSArray* endpointArray = [manager realDestinations];
	NSEnumerator* enumerator = [endpointArray objectEnumerator];
	PYMIDIEndpoint *endpoint;
	PYMIDIEndpoint *selectedEndPoint = nil;
	
	
	while (endpoint = [enumerator nextObject]) {
		
		if ([endpoint displayName] != nil) {
			
			// NSLog(@"%@", [endpoint displayName]);
						
			NSString *name = [endpoint displayName];
			
			if ([@"Network Session 1" isEqualToString:name]) {
				selectedEndPoint = nil;
			} else {
				selectedEndPoint = endpoint;
			}
			
		}
	}
	
	self.midiEndPoint = selectedEndPoint;
	
	return selectedEndPoint;
	
	/*
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"MIDI" message:allNames delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[myAlert show];
	[myAlert release];
	*/
		
}



@end
