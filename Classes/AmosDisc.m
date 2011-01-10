//
//  ShapeCircle.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/6/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"
#import "ShapeBase.h"
#import "AmosAppDelegate.h"
#import "ModeAViewController.h"
#import "AmosMIDIManager.h"
#import "NoteSetting.h"

#import "AmosDisc.h"
#import "DiscSettings.h"

@implementation AmosDisc

@synthesize circleSize;
@synthesize isConfigOpen;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showConfigurationMenu:)];
		[self addGestureRecognizer:longPressGesture];
		[longPressGesture release];
		
		isConfigOpen = NO;
    }
    return self;
}


- (void) setCircleSize:(NSString *)circSize {
	
	circleSize = circSize;
	
		
	if (circleSize == DISC_LARGE) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_half_pan.png"]];			
		duration = 2;
	}
	
	if (circleSize == DISC_MEDIUM) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_quarter_pan.png"]];			
		duration = 1;		
	}
	
	if (circleSize == DISC_SMALL) {
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_base.png"]];
		noteOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_on.png"]];
		panLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_note_eighth_pan.png"]];			
		
		duration = .5;	
	}
	
		
	
	base.backgroundColor = [UIColor clearColor];
	base.opaque = NO;
	[self addSubview:base];
	
	noteOn.backgroundColor = [UIColor clearColor];
	noteOn.opaque = NO;
	noteOn.alpha = 0;
	[self addSubview:noteOn];
	
	
	panLight.backgroundColor = [UIColor clearColor];
	panLight.opaque = NO;
	panLight.alpha = 0;
	[self addSubview:panLight];
	
	
}




- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	CGSize screenSize = delegate.modeA.view.bounds.size;
	CGPoint p = self.center;
	
	// Body def
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, (screenSize.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	fixtureDef.density = 1.0f;	
	fixtureDef.restitution = 1.0f;				
	float32 size;
	
	// Shape def
	
	if (circleSize == DISC_SMALL) {
		size = 72/PTM_RATIO;
		size = 4.5;	
	}
	if (circleSize == DISC_MEDIUM) {
		size = 80/PTM_RATIO;
		fixtureDef.friction = 0.15f;
	}
	if (circleSize == DISC_LARGE) {
		size = 88/PTM_RATIO;
		size = 5.5f;
		fixtureDef.friction = 0.2f;
	}
	
	circleShape.m_radius = size;
	fixtureDef.shape = &circleShape;	
}


- (void)showConfigurationMenu:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        // NSLog(@"Long press");
		
		isConfigOpen = YES;
						
		CGSize contentSize = CGSizeMake(280, 180);
		CGRect contentFrame = self.frame;
		contentFrame.origin.y += self.frame.size.height/2;
		
		contentFrame.origin.x = ceil(contentFrame.origin.x);
		contentFrame.origin.y = ceil(contentFrame.origin.y);

		DiscSettings *settingsController = [[DiscSettings alloc] init];
		settingsController.contentSizeForViewInPopover = contentSize;
		UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:settingsController];
		popover.popoverContentSize = contentSize;
		popover.delegate = self;
		
		[popover presentPopoverFromRect:contentFrame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
		
		[settingsController release];
		
		// Rise to the top
		[self.superview addSubview:self];
		 
		self.body->SetSleepingAllowed(true);
		self.body->SetAwake(false);
		self.body->SetActive(false);
		
		[UIView animateWithDuration:.33
							  delay:0
							options:UIViewAnimationOptionAllowUserInteraction
						 animations:^{ 
							 noteOn.alpha = 1;
						 }
						 completion:^(BOOL finished){}
						 ];
		

    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	self.isConfigOpen = NO;
	self.body->SetAwake(true);
	self.body->SetActive(true);
	
	
	[UIView animateWithDuration:.33
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 noteOn.alpha = 0;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	
	
	
	return YES;
}



- (void)dealloc {
    [super dealloc];
}


@end
