    //
//  DSMIDIInfoViewController.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/8/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "DSMIDIInfoViewController.h"


@implementation DSMIDIInfoViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.title = @"DSMI";

	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.view = webView;
	
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dsmidi" ofType:@"html" inDirectory:@"/"]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
    [super dealloc];
}


@end
