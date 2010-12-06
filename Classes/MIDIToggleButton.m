//
//  MIDIToggleButton.m
//  Amos
//
//  Created by Justin Rhoades on 12/5/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "MIDIToggleButton.h"
#import "ModeAViewController.h"

@class ModeAViewController;


@implementation MIDIToggleButton

@synthesize controller;
@synthesize isOn;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
        
		image_on = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_midi_on.png"]];
		image_on.backgroundColor = [UIColor clearColor];
		image_on.opaque = NO;
		[self addSubview:image_on];
		
		image_off = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_midi_off.png"]];
		image_off.backgroundColor = [UIColor clearColor];
		image_off.opaque = NO;
		image_off.alpha = 0;
		[self addSubview:image_off];
		
		image_active = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_midi_active.png"]];
		image_active.backgroundColor = [UIColor clearColor];
		image_active.opaque = NO;
		image_active.alpha = 0;
		[self addSubview:image_active];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
		[tapGesture setDelegate:self];
		[self addGestureRecognizer:tapGesture];
		[tapGesture release];
		
		self.isOn = YES;
		
    }
    return self;
}

- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer {
	
	[self toggle];
	
	[controller toggleMIDI];
}

- (void) toggle {
	
	self.isOn = !self.isOn;
	
	if (self.isOn) {
		image_off.alpha = 0;
		image_on.alpha = 1;
	} else {
		image_off.alpha = 1;
		image_on.alpha = 0;
	}
}

- (void) playNote {
	
	if (self.isOn) {
		
		[UIView animateWithDuration:.01
							  delay:0
							options:UIViewAnimationOptionAllowUserInteraction
						 animations:^{ 
							 image_active.alpha = 1;
						 }
						 completion:^(BOOL finished){
							 [UIView animateWithDuration:.33
												   delay:0
												 options:UIViewAnimationOptionAllowUserInteraction
											  animations:^{
												  image_active.alpha = 0;
											  }
											  completion:^(BOOL finished){
												  ;
											  }
							  ];}];
		
		
	}
	
	
	
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
