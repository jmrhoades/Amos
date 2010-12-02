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
        
		image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
		image.backgroundColor = [UIColor clearColor];
		image.opaque = NO;
		[self addSubview:image];
		
		image_active = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_over.png"]];
		image_active.backgroundColor = [UIColor clearColor];
		image_active.opaque = NO;
		image_active.alpha = 0;
		[self addSubview:image_active];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
		[tapGesture setDelegate:self];
		[self addGestureRecognizer:tapGesture];
		[tapGesture release];
		
	}
    return self;
}

- (void)tap:(UIPanGestureRecognizer *)gestureRecognizer {
	image.alpha = 1;
	image_active.alpha = 0;
	
	[controller showSettings];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	image.alpha = 0;
	image_active.alpha = 1;
	
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	image.alpha = 1;
	image_active.alpha = 0;
}

- (void)dealloc {
    [super dealloc];
}


@end
