//
//  AmosSetNotesButton.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/1/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "AmosSettingsButton.h"
#import "ModeAViewController.h"


@implementation AmosSettingsButton


@synthesize controller;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
        
		image_off = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_settings_on.png"]];
		image_off.backgroundColor = [UIColor clearColor];
		image_off.opaque = NO;
		[self addSubview:image_off];
		
		image_on = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_settings_off.png"]];
		image_on.backgroundColor = [UIColor clearColor];
		image_on.opaque = NO;
		image_on.alpha = 0;
		[self addSubview:image_on];
		
		image_active = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_settings_active.png"]];
		image_active.backgroundColor = [UIColor clearColor];
		image_active.opaque = NO;
		image_active.alpha = 0;
		[self addSubview:image_active];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
		[tapGesture setDelegate:self];
		[self addGestureRecognizer:tapGesture];
		[tapGesture release];
		
		isOn = NO;
		
	}
    return self;
}

- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer {
	
	[self toggle];
	
	[controller showSettings];
}

- (void) toggle {
	
	isOn = !isOn;
	
	if (isOn) {
		image_off.alpha = 0;
		image_on.alpha = 1;
	} else {
		image_off.alpha = 1;
		image_on.alpha = 0;
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//image_active.alpha = 1;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//image_active.alpha = 0;
}

- (void)dealloc {
    [super dealloc];
}


@end
