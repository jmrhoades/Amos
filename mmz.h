/*
 *  mmz.h
 *
 *  Created by Evan Olcott on 12/5/09.
 *  Copyright 2009-10 Audiofile Engineering. All rights reserved.
 *
 */

//
// HOW TO USE libmmz
//

// to use mmz in your application, follow these steps:
// 1. add libmmz.a and mmz.h to your XCode project
// 2. in your application target's build settings, add "-all_load" to "Other Linker Flags"
// 3. confirm that libmmz.a is in the "Link Binary With Libraries" phase
// 4. confirm that ExternalAccessory.framework is linked against the project

// note that libmmz.a is compiled for the Device and not the Simulator
// applications that include libmmz.a will not be able to run in the Simulator

//
// MIDI MESSAGES
//

// The MZMIDIMessage class is the base class for all MIDI messages to be sent or received
// through the MIDI Mobilizer. It allows for easy access to all properties for MIDI messages
// and for easy classification. Each type of MIDI Message (note on, controller, pitch wheel, etc)
// is a subclass of MZMIDIMessage.

// timestamp is in milliseconds
// - for incoming messages, this is the number of milliseconds since the first message arrived
//	 at the MIDI Mobilizer interface
// - for outgoing messages, this is the number of milliseconds after the first MIDI message sent
//	 after the application starts or the resetClock method is called.
// dataLength is the number of bytes in the full MIDI message
// data is the MIDI message, including the status byte

@interface MZMIDIMessage : NSObject
{
	NSUInteger timestamp; // ms
	NSUInteger dataLength;
	unsigned char *data;
}

// will return a message of the receiver's class with the data pre-allocated
+ (id)message;

// will return an MZMIDIMessage with the class determined by the contents of data
//	with the timestamp t
+ (id)messageWithData:(NSData *)data timestamp:(NSUInteger)t;

// will return an MZMIDIMessage with the class determined by the contents of bytes
//	and the timestamp t
+ (id)messageWithBytes:(const unsigned char *)bytes timestamp:(NSUInteger)t;

// returns the MZMIDIMessage subclass for the given bytes
+ (Class)classForMIDIBytes:(const unsigned char *)bytes;

// returns the expected dataLength for an MZMIDIMessage with the given status byte
+ (NSUInteger)messageLengthForStatus:(unsigned char)status;

// appends the SMF-style value to the data block
//	useful when constructing MIDI data streams with timestamps or lengths
+ (void)appendSMFValue:(unsigned int)value toData:(NSMutableData *)data;

// returns the expected length of a MIDI message for the class
+ (NSUInteger)length;

// returns the category of a MIDI message of this receiver's class (the upper 4 bits of the status byte) 
+ (unsigned char)category;

// returns the full, localized name of the receiver's MIDI message category
+ (NSString *)name;

// returns an 8-character abbreviated name of the receiver's MIDI message category
//	useful for reading in the Console log
+ (NSString *)logName;

// creates a MIDI message with the given bytes and timestamp
- (id)initWithBytes:(const unsigned char *)bytes length:(NSUInteger)length timestamp:(NSUInteger)t;

// returns the status byte of the MIDI message
- (unsigned char)status;

// returns the category of the MIDI message (the upper 4 bits of the status byte)
- (unsigned char)category;

// returns the result of a comparison of the data of a MIDI message to the receiver
// NOTE: the timestamp is not included in the comparison
- (BOOL)isEqualToMessage:(MZMIDIMessage *)message;

// returns a formatted description of the contents of the MIDI message
//	useful for reading in the Console log
- (NSString *)logDescription;

// returns the MIDI message data formatted appropriately for SMF-style delivery
//	- this does NOT include the timestamp
- (NSData *)standardMIDIFileData;

@property NSUInteger timestamp;
@property(readonly) NSUInteger dataLength;
@property(readonly) unsigned char *data;

@end


@interface MZMIDIVoiceMessage : MZMIDIMessage

// channels are NOT 0-based. they are READABLE-based (1 - 16).
// channel 0 is an illegal channel number and will be ignored.
- (unsigned char)channel;
- (void)setChannel:(unsigned char)c;

@end

@interface MZMIDINoteMessage : MZMIDIVoiceMessage

- (unsigned char)note;
- (void)setNote:(unsigned char)n;
- (unsigned char)velocity;
- (void)setVelocity:(unsigned char)v;

@end

@interface MZMIDINoteOnMessage : MZMIDINoteMessage

@end

@interface MZMIDINoteOffMessage : MZMIDINoteMessage

@end

@interface MZMIDIAftertouchMessage : MZMIDINoteMessage

- (unsigned char)pressure;
- (void)setPressure:(unsigned char)v;

@end

@interface MZControllerMessage : MZMIDIVoiceMessage

- (unsigned char)number;
- (void)setNumber:(unsigned char)n;
- (unsigned char)value;
- (void)setValue:(unsigned char)v;
- (float)floatValue;
- (void)setFloatValue:(float)v;

@end

@interface MZMIDIProgramChangeMessage : MZMIDIVoiceMessage

- (unsigned char)number;
- (void)setNumber:(unsigned char)n;

@end

@interface MZMIDIChannelPressureMessage : MZMIDIVoiceMessage

- (unsigned char)pressure;
- (void)setPressure:(unsigned char)p;

@end

@interface MZMIDIPitchWheelMessage : MZMIDIVoiceMessage

- (unsigned short)value;
- (void)setValue:(unsigned short)v;
- (float)floatValue;
- (void)setFloatValue:(float)v;

@end

@interface MZMIDIMTCQuarterFrameMessage : MZMIDIMessage 

- (unsigned char)timecode;
- (void)setTimecode:(unsigned char)t;

@end

@interface MZMIDISongPositionMessage : MZMIDIMessage

- (unsigned short)beat;
- (void)setBeat:(unsigned short)b;

@end

@interface MZMIDISongSelectMessage : MZMIDIMessage

- (unsigned char)songNumber;
- (void)setSongNumber:(unsigned char)n;

@end

@interface MZMIDITuneRequestMessage : MZMIDIMessage

@end

@interface MZMIDIClockMessage : MZMIDIMessage

@end

@interface MZMIDITickMessage : MZMIDIMessage

@end

@interface MZMIDIStartMessage : MZMIDIMessage

@end

@interface MZMIDIContinueMessage : MZMIDIMessage

@end

@interface MZMIDIStopMessage : MZMIDIMessage

@end

@interface MZMIDIActiveSenseMessage : MZMIDIMessage

@end

@interface MZMIDISysexMessage : MZMIDIMessage

- (unsigned short)manufacturerID;

// sysexData is a convenience accessor to the contents of the sysex data stream,
// separate from header and footer bytes (F0, F7 and others)
- (NSUInteger)sysexDataLength;
- (void *)sysexData;

@end

@interface MZMIDIUniversalMessage : MZMIDIMessage

- (BOOL)isRealtime;
- (void)setIsRealtime:(BOOL)r;
- (unsigned char)sysexID;
- (void)setSysexID:(unsigned char)s;

@end

enum
{
    MZMIDIMessageSMPTETimeType24        = 0,
    MZMIDIMessageSMPTETimeType25        = 1,
    MZMIDIMessageSMPTETimeType30Drop    = 2,
    MZMIDIMessageSMPTETimeType30        = 3,
};

@interface MZMIDIMTCFullFrameMessage : MZMIDIUniversalMessage

- (NSUInteger)rate;
- (void)setRate:(NSUInteger)r;
- (unsigned char)type;
- (void)setType:(unsigned char)t;
- (unsigned char)hours;
- (void)setHours:(unsigned char)h;
- (unsigned char)minutes;
- (void)setMinutes:(unsigned char)m;
- (unsigned char)seconds;
- (void)setSeconds:(unsigned char)s;
- (unsigned char)frames;
- (void)setFrames:(unsigned char)f;

@end

//
#pragma mark -
// CONTROLLER
//

// The MZController delegate can optionally respond to two methods:
// - midiInput: delivers a single, full MIDI message
// - midiOutputQueueDidEmpty: a notification when the sending MIDI queue has finished sending the data
//	 to the MIDI Mobilizer. Note that this is not the same as when the data has been sent from the
//	 MIDI Mobilizer (there will usually be a delay of less than 0.5 seconds).

@protocol MZControllerDelegateProtocol <NSObject>
@optional

- (void)midiInput:(MZMIDIMessage *)message;
- (void)midiOutputQueueDidEmpty;

@end

// The MZController is the singleton object that controls communication with the MIDI Mobilizer

// To include in your application, simply call startupWithDelegate: in the applicationDidFinishLaunching:
// method of your application delegate.

// To properly close communications with the MIDI Mobilizer when your app quits, call shutdown in the
// applicationWillTerminate: method of your application delegate

// To be notified when the MIDI Mobilizer is connected or disconnected, add an observer to the
// default NSNotificationCenter for the names
// "MZMIDIMobilizerDidConnect" and "MZMIDIMobilizerDidDisconnect"

@interface MZController : NSObject
{
	id <MZControllerDelegateProtocol> delegate;
	
@private
	NSString *firmwareVersion;
}

+ (MZController *)sharedController;
+ (MZController *)startupWithDelegate:(id <MZControllerDelegateProtocol>)delegate;
+ (void)shutdown;

// returns YES when the MIDI Mobilizer communication channel is open and has responded
//	to a simple test query
- (BOOL)isHardwareConnected;

// resets the MIDI Mobilizer's clock. The next MIDI message to be output will start the clock,
//	and further MIDI message timestamps will reference it as time 0.
//	NOTE: the first MIDI message after this call is made MUST have a timestamp of 0
- (void)resetClock;

// sends a single MIDI message to the MIDI Mobilizer
//	the message will be sent the given number of milliseconds after the
//	last message whose timestamp was 0 was sent
// the message is copied before it is queued
- (void)sendMessage:(MZMIDIMessage *)message;

// sends an array of MIDI messages to the MIDI Mobilizer
//	the message will be sent the given number of milliseconds after the
//	last message whose timestamp was 0 was sent
// the messages are copied before they are queued
- (void)sendMessages:(NSArray *)messages;

// use these methods to pause the messages in the queue from being sent
// to the MIDI Mobilizer. This will also send an array of messages
// to turn off notes that are on and controllers that are non-zero.
- (BOOL)isPaused;
- (void)setPaused:(BOOL)p;

// will remove all the messages currently queued to be sent to the MIDI Mobilizer
// This will also send an array of messages to turn off notes that are on
// and controllers that are non-zero.
- (void)stop;

@property(retain) NSString *firmwareVersion;

@end
