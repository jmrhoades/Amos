//
//  DiscSettings.h
//  Amos
//
//  Created by Justin Rhoades on 1/8/11.
//  Copyright 2011 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiscSettings : UIViewController {
	UIImageView *background;
	
	UIImageView *sixteenthOn;
	UIImageView *eighthOn;
	UIImageView *quarterOn;
	UIImageView *halfOn;
	UIImageView *wholeOn;
	
	UIView *activeTiming;
	
	
	UIImageView *midiChannel1On;
	UIImageView *midiChannel2On;
	UIImageView *midiChannel3On;
	UIImageView *midiChannel4On;
	UIImageView *midiChannel5On;
	UIImageView *midiChannel6On;
	UIImageView *midiChannel7On;
	UIImageView *midiChannel8On;
	UIImageView *midiChannel9On;
	UIImageView *midiChannel10On;
	UIImageView *midiChannel11On;
	UIImageView *midiChannel12On;
	UIImageView *midiChannel13On;
	UIImageView *midiChannel14On;
	UIImageView *midiChannel15On;
	UIImageView *midiChannel16On;

	UIView *activeMIDIChannel;


}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIImageView *sixteenthOn;
@property (nonatomic, retain) UIImageView *eighthOn;
@property (nonatomic, retain) UIImageView *quarterOn;
@property (nonatomic, retain) UIImageView *halfOn;
@property (nonatomic, retain) UIImageView *wholeOn;
@property (nonatomic, retain) UIView *activeTiming;

@property (nonatomic, retain) UIImageView *midiChannel1On;
@property (nonatomic, retain) UIImageView *midiChannel2On;
@property (nonatomic, retain) UIImageView *midiChannel3On;
@property (nonatomic, retain) UIImageView *midiChannel4On;
@property (nonatomic, retain) UIImageView *midiChannel5On;
@property (nonatomic, retain) UIImageView *midiChannel6On;
@property (nonatomic, retain) UIImageView *midiChannel7On;
@property (nonatomic, retain) UIImageView *midiChannel8On;
@property (nonatomic, retain) UIImageView *midiChannel9On;
@property (nonatomic, retain) UIImageView *midiChannel10On;
@property (nonatomic, retain) UIImageView *midiChannel11On;
@property (nonatomic, retain) UIImageView *midiChannel12On;
@property (nonatomic, retain) UIImageView *midiChannel13On;
@property (nonatomic, retain) UIImageView *midiChannel14On;
@property (nonatomic, retain) UIImageView *midiChannel15On;
@property (nonatomic, retain) UIImageView *midiChannel16On;

@property (nonatomic, retain) UIView *activeMIDIChannel;


-(void)setTiming:(UIView *)newTimingView;
-(void)setMIDIChannel:(UIView *)newMIDIChannelView;


@end
