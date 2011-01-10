    //
//  DiscSettings.m
//  Amos
//
//  Created by Justin Rhoades on 1/8/11.
//  Copyright 2011 Anything Honest. All rights reserved.
//

#import "DiscSettings.h"


@implementation DiscSettings


@synthesize background;

@synthesize sixteenthOn;
@synthesize eighthOn;
@synthesize quarterOn;
@synthesize halfOn;
@synthesize wholeOn;
@synthesize activeTiming;

@synthesize midiChannel1On;
@synthesize midiChannel2On;
@synthesize midiChannel3On;
@synthesize midiChannel4On;
@synthesize midiChannel5On;
@synthesize midiChannel6On;
@synthesize midiChannel7On;
@synthesize midiChannel8On;
@synthesize midiChannel9On;
@synthesize midiChannel10On;
@synthesize midiChannel11On;
@synthesize midiChannel12On;
@synthesize midiChannel13On;
@synthesize midiChannel14On;
@synthesize midiChannel15On;
@synthesize midiChannel16On;
@synthesize activeMIDIChannel;



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"discSettingsBackground.png"]];
	[self.view addSubview:background];
	
	
	// noteLengthLabel
	UILabel *noteLengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 16)];
	noteLengthLabel.backgroundColor = [UIColor clearColor];
	noteLengthLabel.opaque = NO;		
	noteLengthLabel.textAlignment = UITextAlignmentLeft;
	noteLengthLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.6];
	//noteLengthLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	//noteLengthLabel.shadowOffset = CGSizeMake(0,-1);	
	noteLengthLabel.font = [UIFont systemFontOfSize:11.0];
	noteLengthLabel.text = @"Note Length";
	[self.view addSubview:noteLengthLabel];
	
	// midiChannelLabel
	UILabel *midiChannelLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 90, 200, 16)];
	midiChannelLabel.backgroundColor = [UIColor clearColor];
	midiChannelLabel.opaque = NO;		
	midiChannelLabel.textAlignment = UITextAlignmentLeft;
	midiChannelLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.6];
	//noteLengthLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	//noteLengthLabel.shadowOffset = CGSizeMake(0,-1);	
	midiChannelLabel.font = [UIFont systemFontOfSize:11.0];
	midiChannelLabel.text = @"MIDI Channel";
	[self.view addSubview:midiChannelLabel];
	
	 // sixteenthTiming
	 UILabel *sixteenthTiming = [[UILabel alloc] initWithFrame:CGRectMake(1, 65, 56, 18)];
	 sixteenthTiming.backgroundColor = [UIColor clearColor];
	 sixteenthTiming.opaque = NO;		
	 sixteenthTiming.textAlignment = UITextAlignmentCenter;
	 sixteenthTiming.textColor = [UIColor colorWithRed:1.0*115/256 green:1.0*121/256 blue:1.0*128/256 alpha:1];
	 sixteenthTiming.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	 sixteenthTiming.shadowOffset = CGSizeMake(0,-1);	
	 sixteenthTiming.font = [UIFont systemFontOfSize:10.0];
	 sixteenthTiming.text = @"125 ms";
	 [self.view addSubview:sixteenthTiming];
	
	// eighthTiming
	UILabel *eighthTiming = [[UILabel alloc] initWithFrame:CGRectMake(57, 65, 56, 18)];
	eighthTiming.backgroundColor = [UIColor clearColor];
	eighthTiming.opaque = NO;		
	eighthTiming.textAlignment = UITextAlignmentCenter;
	eighthTiming.textColor = [UIColor colorWithRed:1.0*115/256 green:1.0*121/256 blue:1.0*128/256 alpha:1];
	eighthTiming.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	eighthTiming.shadowOffset = CGSizeMake(0,-1);	
	eighthTiming.font = [UIFont systemFontOfSize:10.0];
	eighthTiming.text = @"250 ms";
	[self.view addSubview:eighthTiming];
	
	// quarterTiming
	UILabel *quarterTiming = [[UILabel alloc] initWithFrame:CGRectMake(113, 65, 56, 18)];
	quarterTiming.backgroundColor = [UIColor clearColor];
	quarterTiming.opaque = NO;		
	quarterTiming.textAlignment = UITextAlignmentCenter;
	quarterTiming.textColor = [UIColor colorWithRed:1.0*115/256 green:1.0*121/256 blue:1.0*128/256 alpha:1];
	quarterTiming.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	quarterTiming.shadowOffset = CGSizeMake(0,-1);	
	quarterTiming.font = [UIFont systemFontOfSize:10.0];
	quarterTiming.text = @"500 ms";
	[self.view addSubview:quarterTiming];
	
	// halfTiming
	UILabel *halfTiming = [[UILabel alloc] initWithFrame:CGRectMake(169, 65, 56, 18)];
	halfTiming.backgroundColor = [UIColor clearColor];
	halfTiming.opaque = NO;		
	halfTiming.textAlignment = UITextAlignmentCenter;
	halfTiming.textColor = [UIColor colorWithRed:1.0*115/256 green:1.0*121/256 blue:1.0*128/256 alpha:1];
	halfTiming.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	halfTiming.shadowOffset = CGSizeMake(0,-1);	
	halfTiming.font = [UIFont systemFontOfSize:10.0];
	halfTiming.text = @"1000 ms";
	[self.view addSubview:halfTiming];
	
	// wholeTiming
	UILabel *wholeTiming = [[UILabel alloc] initWithFrame:CGRectMake(225, 65, 56, 18)];
	wholeTiming.backgroundColor = [UIColor clearColor];
	wholeTiming.opaque = NO;		
	wholeTiming.textAlignment = UITextAlignmentCenter;
	wholeTiming.textColor = [UIColor colorWithRed:1.0*115/256 green:1.0*121/256 blue:1.0*128/256 alpha:1];
	wholeTiming.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	wholeTiming.shadowOffset = CGSizeMake(0,-1);	
	wholeTiming.font = [UIFont systemFontOfSize:10.0];
	wholeTiming.text = @"2000 ms";
	[self.view addSubview:wholeTiming];
	 
	
	
	CGRect f;
	f.origin.y = 18;
	f.origin.x = 0;
	f.size.width = 56;
	f.size.height = 72;	
	
	CGRect noteBounds;
	noteBounds.size.width = 56;
	noteBounds.size.height = 72;	
	
	
	// sixteenthTiming
	self.sixteenthOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sixteenthOn.png"]];
	[self.view addSubview:self.sixteenthOn];
	f.origin.x = 0;	
	self.sixteenthOn.frame = f;
	self.sixteenthOn.bounds = noteBounds;
	self.sixteenthOn.clipsToBounds = YES;
	self.sixteenthOn.alpha = 0;
	
	UILabel *sixteenthOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 47, 56, 18)];
	sixteenthOnLabel.backgroundColor = [UIColor clearColor];
	sixteenthOnLabel.opaque = NO;		
	sixteenthOnLabel.textAlignment = UITextAlignmentCenter;
	sixteenthOnLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.9];
	sixteenthOnLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	sixteenthOnLabel.shadowOffset = CGSizeMake(0,-1);	
	sixteenthOnLabel.font = [UIFont systemFontOfSize:10.0];
	sixteenthOnLabel.text = @"125 ms";
	[self.sixteenthOn addSubview:sixteenthOnLabel];
	
	
	// eighthTiming
	self.eighthOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eighthOn.png"]];
	[self.view addSubview:self.eighthOn];	
	f.origin.x = 56;
	self.eighthOn.frame = f;
	self.eighthOn.bounds = noteBounds;
	self.eighthOn.clipsToBounds = YES;	
	self.eighthOn.alpha = 0;
	
	UILabel *eighthOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 47, 56, 18)];
	eighthOnLabel.backgroundColor = [UIColor clearColor];
	eighthOnLabel.opaque = NO;		
	eighthOnLabel.textAlignment = UITextAlignmentCenter;
	eighthOnLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.9];
	eighthOnLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	eighthOnLabel.shadowOffset = CGSizeMake(0,-1);	
	eighthOnLabel.font = [UIFont systemFontOfSize:10.0];
	eighthOnLabel.text = @"250 ms";
	[self.eighthOn addSubview:eighthOnLabel];
	
	
	// quarterTiming
	self.quarterOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quarterOn.png"]];
	[self.view addSubview:self.quarterOn];	
	f.origin.x = 112;
	self.quarterOn.frame = f;
	self.quarterOn.bounds = noteBounds;
	self.quarterOn.clipsToBounds = YES;	
	self.quarterOn.alpha = 0;
	
	UILabel *quarterOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 47, 56, 18)];
	quarterOnLabel.backgroundColor = [UIColor clearColor];
	quarterOnLabel.opaque = NO;		
	quarterOnLabel.textAlignment = UITextAlignmentCenter;
	quarterOnLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.9];
	quarterOnLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	quarterOnLabel.shadowOffset = CGSizeMake(0,-1);	
	quarterOnLabel.font = [UIFont systemFontOfSize:10.0];
	quarterOnLabel.text = @"500 ms";
	[self.quarterOn addSubview:quarterOnLabel];
	
	// halfTiming
	self.halfOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"halfOn.png"]];
	[self.view addSubview:self.halfOn];	
	f.origin.x = 168;
	self.halfOn.frame = f;
	self.halfOn.bounds = noteBounds;
	self.halfOn.clipsToBounds = YES;	
	self.halfOn.alpha = 0;
	
	UILabel *halfOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 47, 56, 18)];
	halfOnLabel.backgroundColor = [UIColor clearColor];
	halfOnLabel.opaque = NO;		
	halfOnLabel.textAlignment = UITextAlignmentCenter;
	halfOnLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.9];
	halfOnLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	halfOnLabel.shadowOffset = CGSizeMake(0,-1);	
	halfOnLabel.font = [UIFont systemFontOfSize:10.0];
	halfOnLabel.text = @"1000 ms";
	[self.halfOn addSubview:halfOnLabel];
	
	
	// wholeTiming
	self.wholeOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wholeOn.png"]];
	[self.view addSubview:self.wholeOn];	
	f.origin.x = 224;
	self.wholeOn.frame = f;
	self.wholeOn.bounds = noteBounds;
	self.wholeOn.clipsToBounds = YES;	
	self.wholeOn.alpha = 0;
	
	UILabel *wholeOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 47, 56, 18)];
	wholeOnLabel.backgroundColor = [UIColor clearColor];
	wholeOnLabel.opaque = NO;		
	wholeOnLabel.textAlignment = UITextAlignmentCenter;
	wholeOnLabel.textColor = [UIColor colorWithRed:1.0*256/256 green:1.0*256/256 blue:1.0*256/256 alpha:.9];
	wholeOnLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	wholeOnLabel.shadowOffset = CGSizeMake(0,-1);	
	wholeOnLabel.font = [UIFont systemFontOfSize:10.0];
	wholeOnLabel.text = @"2000 ms";
	[self.wholeOn addSubview:wholeOnLabel];
	
	self.activeTiming = nil;
	
	
	CGRect midiChannelFrame;
	midiChannelFrame.origin.y = 108;
	midiChannelFrame.origin.x = 0;
	midiChannelFrame.size.width = 35;
	midiChannelFrame.size.height = 36;	
	CGRect midiChannelBounds;
	midiChannelBounds.size.width = 35;
	midiChannelBounds.size.height = 36;	
	
	
	// midiChannel1On
	self.midiChannel1On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel1On.png"]];
	[self.view addSubview:self.midiChannel1On];	
	midiChannelFrame.origin.x = 0;
	midiChannelFrame.origin.y = 108;
	self.midiChannel1On.frame = midiChannelFrame;
	self.midiChannel1On.alpha = 0;
	
	// midiChannel2On
	self.midiChannel2On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel2On.png"]];
	[self.view addSubview:self.midiChannel2On];	
	midiChannelFrame.origin.x = 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel2On.frame = midiChannelFrame;	
	self.midiChannel2On.alpha = 0;
	
	// midiChannel3On
	self.midiChannel3On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel3On.png"]];
	[self.view addSubview:self.midiChannel3On];	
	midiChannelFrame.origin.x = 70;
	midiChannelFrame.origin.y = 108;
	self.midiChannel3On.frame = midiChannelFrame;	
	self.midiChannel3On.alpha = 0;
	
	// midiChannel4On
	self.midiChannel4On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel4On.png"]];
	[self.view addSubview:self.midiChannel4On];	
	midiChannelFrame.origin.x = 3 * 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel4On.frame = midiChannelFrame;	
	self.midiChannel4On.alpha = 0;
	
	// midiChannel5On
	self.midiChannel5On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel5On.png"]];
	[self.view addSubview:self.midiChannel5On];	
	midiChannelFrame.origin.x = 4 * 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel5On.frame = midiChannelFrame;
	self.midiChannel5On.alpha = 0;
	
	// midiChannel6On
	self.midiChannel6On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel6On.png"]];
	[self.view addSubview:self.midiChannel6On];	
	midiChannelFrame.origin.x = 5 * 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel6On.frame = midiChannelFrame;
	self.midiChannel6On.bounds = midiChannelBounds;
	self.midiChannel6On.clipsToBounds = YES;	
	self.midiChannel6On.alpha = 0;
	
	// midiChannel7On
	self.midiChannel7On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel7On.png"]];
	[self.view addSubview:self.midiChannel7On];	
	midiChannelFrame.origin.x = 6 * 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel7On.frame = midiChannelFrame;	
	self.midiChannel7On.alpha = 0;
	
	// midiChannel8On
	self.midiChannel8On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel8On.png"]];
	[self.view addSubview:self.midiChannel8On];	
	midiChannelFrame.origin.x = 7 * 35;
	midiChannelFrame.origin.y = 108;
	self.midiChannel8On.frame = midiChannelFrame;	
	self.midiChannel8On.alpha = 0;
	
	// midiChannel9On
	self.midiChannel9On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel9On.png"]];
	[self.view addSubview:self.midiChannel9On];	
	midiChannelFrame.origin.x = 0;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel9On.frame = midiChannelFrame;	
	self.midiChannel9On.alpha = 0;
	
	// midiChannel10On
	self.midiChannel10On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel10On.png"]];
	[self.view addSubview:self.midiChannel10On];	
	midiChannelFrame.origin.x = 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel10On.frame = midiChannelFrame;	
	self.midiChannel10On.alpha = 0;
	
	// midiChannel11On
	self.midiChannel11On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel11On.png"]];
	[self.view addSubview:self.midiChannel11On];	
	midiChannelFrame.origin.x = 70;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel11On.frame = midiChannelFrame;
	self.midiChannel11On.alpha = 0;
	
	// midiChannel12On
	self.midiChannel12On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel12On.png"]];
	[self.view addSubview:self.midiChannel12On];	
	midiChannelFrame.origin.x = 3 * 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel12On.frame = midiChannelFrame;
	self.midiChannel12On.alpha = 0;
	
	// midiChannel13On
	self.midiChannel13On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel13On.png"]];
	[self.view addSubview:self.midiChannel13On];	
	midiChannelFrame.origin.x = 4 * 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel13On.frame = midiChannelFrame;	
	self.midiChannel13On.alpha = 0;
	
	// midiChannel14On
	self.midiChannel14On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel14On.png"]];
	[self.view addSubview:self.midiChannel14On];	
	midiChannelFrame.origin.x = 5 * 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel14On.frame = midiChannelFrame;
	self.midiChannel14On.alpha = 0;
	
	// midiChannel15On
	self.midiChannel15On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel15On.png"]];
	[self.view addSubview:self.midiChannel15On];	
	midiChannelFrame.origin.x = 6 * 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel15On.frame = midiChannelFrame;	
	self.midiChannel15On.alpha = 0;
	
	// midiChannel16On
	self.midiChannel16On = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midiChannel16On.png"]];
	[self.view addSubview:self.midiChannel16On];	
	midiChannelFrame.origin.x = 7 * 35;
	midiChannelFrame.origin.y = 108 + 36;
	self.midiChannel16On.frame = midiChannelFrame;	
	self.midiChannel16On.alpha = 0;
	
	

		
	
	
	self.activeMIDIChannel = nil;
}



// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    for (UITouch *touch in touches) {	
		
		
		if (CGRectContainsPoint([self.sixteenthOn frame], [touch locationInView:self.view])) {
			if (self.activeTiming != self.sixteenthOn) {
				[self setTiming:(UIView *)self.sixteenthOn];
			}
		} 
		
		if (CGRectContainsPoint([self.eighthOn frame], [touch locationInView:self.view])) {
			if (self.activeTiming != self.eighthOn) {
				[self setTiming:(UIView *)self.eighthOn];
			}
		}
		
		if (CGRectContainsPoint([self.quarterOn frame], [touch locationInView:self.view])) {
			if (self.activeTiming != self.quarterOn) {
				[self setTiming:(UIView *)self.quarterOn];
			}
		}
		
		if (CGRectContainsPoint([self.halfOn frame], [touch locationInView:self.view])) {
			if (self.activeTiming != self.halfOn) {
				[self setTiming:(UIView *)self.halfOn];
			}
		}
		
		if (CGRectContainsPoint([self.wholeOn frame], [touch locationInView:self.view])) {
			if (self.activeTiming != self.wholeOn) {
				[self setTiming:(UIView *)self.wholeOn];
			}
		}
		
		
		
		
		
		if (CGRectContainsPoint([self.midiChannel1On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel1On) {
				[self setMIDIChannel:(UIView *)self.midiChannel1On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel2On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel2On) {
				[self setMIDIChannel:(UIView *)self.midiChannel2On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel3On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel3On) {
				[self setMIDIChannel:(UIView *)self.midiChannel3On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel4On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel4On) {
				[self setMIDIChannel:(UIView *)self.midiChannel4On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel5On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel5On) {
				[self setMIDIChannel:(UIView *)self.midiChannel5On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel6On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel6On) {
				[self setMIDIChannel:(UIView *)self.midiChannel6On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel7On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel7On) {
				[self setMIDIChannel:(UIView *)self.midiChannel7On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel8On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel8On) {
				[self setMIDIChannel:(UIView *)self.midiChannel8On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel9On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel9On) {
				[self setMIDIChannel:(UIView *)self.midiChannel9On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel10On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel10On) {
				[self setMIDIChannel:(UIView *)self.midiChannel10On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel11On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel11On) {
				[self setMIDIChannel:(UIView *)self.midiChannel11On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel12On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel12On) {
				[self setMIDIChannel:(UIView *)self.midiChannel12On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel13On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel13On) {
				[self setMIDIChannel:(UIView *)self.midiChannel13On];
			}
		}
		
		if (CGRectContainsPoint([self.midiChannel14On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel14On) {
				[self setMIDIChannel:(UIView *)self.midiChannel14On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel15On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel15On) {
				[self setMIDIChannel:(UIView *)self.midiChannel15On];
			}
		} 
		
		if (CGRectContainsPoint([self.midiChannel16On frame], [touch locationInView:self.view])) {
			if (self.activeMIDIChannel != self.midiChannel16On) {
				[self setMIDIChannel:(UIView *)self.midiChannel16On];
			}
		}
		
		
		
		
	}   
	
}

-(void)setTiming:(UIView *)newTimingView {
	
	
	[self.view addSubview:newTimingView];

	
	[UIView animateWithDuration:.33
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 newTimingView.alpha = 1;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	
	if (self.activeTiming != nil) {
		
		[UIView animateWithDuration:.33
							  delay:0
							options:UIViewAnimationOptionAllowUserInteraction
						 animations:^{ 
							 self.activeTiming.alpha = 0;
						 }
						 completion:^(BOOL finished){}
		 ];
		
	}
	
	self.activeTiming = newTimingView;
	
}

-(void)setMIDIChannel:(UIView *)newMIDIChannelView {
	
	//[self.view addSubview:newMIDIChannelView];
	
	
	[UIView animateWithDuration:.33
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 newMIDIChannelView.alpha = 1;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	
	if (self.activeMIDIChannel != nil) {
		
		[UIView animateWithDuration:.33
							  delay:0
							options:UIViewAnimationOptionAllowUserInteraction
						 animations:^{ 
							 self.activeMIDIChannel.alpha = 0;
						 }
						 completion:^(BOOL finished){}
		 ];
		
	}
	
	self.activeMIDIChannel = newMIDIChannelView;
	
	
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[background release];
    [super dealloc];
}


@end
