//
//  AmosViewController.m
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ModeAViewController.h"
#import "ShapeCircle.h"
#import "ModeACorner.h"
#import "NoteBlock.h"
#import "AmosPhysicsKeyboard.h"
#import "AmosSettingsButton.h"
#import "SettingsViewController.h"
#import "NoteSetting.h"
#import "AmosAppDelegate.h"
#import "AmosMIDIManager.h"
#import "BottomBlock.h"
#import "MIDIToggleButton.h"

@implementation ModeAViewController

@synthesize circleQuarterNote;
@synthesize circleSixteenthNote;
@synthesize circleWholeNote;
@synthesize circleHalfNote;
@synthesize circleEighthNote;

@synthesize midiOnOffButton;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
	
	noteBlocks = [[NSMutableArray alloc] init];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	// Background
	UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
	[self.view addSubview:background];
	[background release];
	
	[self createPhysicsWorld];
	
	[self createEdgeWalls];
		
	[self createKeyboards];
	
	[self createWorldObjects];

	[self createCorners];
	
	// Nav bar background
	UIImageView *temp_top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar.png"]];
	[self.view addSubview:temp_top];
	[temp_top release];

	// Settings popover trigger
	settingsButton = [[AmosSettingsButton alloc] initWithFrame:CGRectMake(768-25-50, 0, 50, 50)];
	settingsButton.controller = self;
	[self.view addSubview:settingsButton];
	
	// MIDI Toggle Button
	midiOnOffButton = [[MIDIToggleButton alloc] initWithFrame:CGRectMake(25, 0, 50, 50)];
	midiOnOffButton.controller = self;
	[self.view addSubview:midiOnOffButton];
	
	/*
	// Centered title
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(354, 11, 60, 20)];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.opaque = NO;		
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.95];	
	titleLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.9];
	titleLabel.shadowOffset = CGSizeMake(0,-1);	
	titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
	titleLabel.text = @"Amos";
	//titleLabel.alpha = .5;
	[self.view addSubview:titleLabel];
	 */

	//Configure and start accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60.0)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
	
	//NSLog(@"convertToGL %@", [[UIDevice currentDevice] orientation]);
	
	
	
}

- (void) bpmSliderAction:(id)sender {
	int val = ceil(bpmSlider.value);
	NSString *s = [NSString stringWithFormat:@"%i BPM", val];
	bpmLabel.text = s;
	
	
}

-(void)createKeyboards {
	
	UIView *keyboardContainer = [[UIView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:keyboardContainer];
	
	
	keyboardTop = [[AmosPhysicsKeyboard alloc] initWithView:keyboardContainer world:world groundBody:groundBody andType:KEYBOARD_TOP];
	[noteBlocks addObjectsFromArray:keyboardTop.noteBlocks];
	
	/*
	keyboardBot = [[AmosPhysicsKeyboard alloc] initWithView:keyboardContainer world:world groundBody:groundBody andType:KEYBOARD_BOT];
	[noteBlocks addObjectsFromArray:keyboardBot.noteBlocks];
	*/
	
	keyboardLeft = [[AmosPhysicsKeyboard alloc] initWithView:keyboardContainer world:world groundBody:groundBody andType:KEYBOARD_LEFT];
	[noteBlocks addObjectsFromArray:keyboardLeft.noteBlocks];
	
	keyboardRight = [[AmosPhysicsKeyboard alloc] initWithView:keyboardContainer world:world groundBody:groundBody andType:KEYBOARD_RIGHT];
	[noteBlocks addObjectsFromArray:keyboardRight.noteBlocks];
	
	[keyboardContainer release];
	
}


-(void)showSettings {
	
	CGSize tableSize = CGSizeMake(380, 530);
	
	SettingsViewController *settingsController = [[SettingsViewController alloc] init];
	settingsController.navigationItem.title = @"Settings";
	settingsController.contentSizeForViewInPopover = tableSize;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navController];
	popover.popoverContentSize = CGSizeMake(380, 690);
	popover.delegate = self;
	CGRect f = settingsButton.frame;
	f.origin.x -= 9;
	[popover presentPopoverFromRect:f inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

	[settingsController release];
	[navController release];
	//[popover release];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	[settingsButton toggle];
	return YES;
}

-(void) noteSettingsDidChange {
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager buildMidiNoteRange];
	
	[keyboardTop updateNotes];
	//[keyboardBot updateNotes];
	[keyboardLeft updateNotes];	
	[keyboardRight updateNotes];	
}

-(void) toggleMIDI {
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager toggleMIDIOn];	
}
	

-(void) toggleShape:(int)shapeTag status:(bool)isOn {
	NSLog(@"toggleShape %d %d", shapeTag, isOn);

	switch(shapeTag) {
		case(1): 
			
			// Circle Half Note
			if (isOn) {
				[circleHalfNote turnOn];		
			} else {
				[circleHalfNote turnOff];		
			}
			
			break;
			
		case(2):
			
			// Circle Quarter Note
			if (isOn) {
				[circleQuarterNote turnOn];		
			} else {
				[circleQuarterNote turnOff];		
			}
			
			break;
			
		case(3):
			
			// Circle Eighth Note
			if (isOn) {
				[circleEighthNote turnOn];		
			} else {
				[circleEighthNote turnOff];		
			}
			
			break;
	}
	
	
	
}


-(void)createPhysicsWorld  {
	
	
	// Define the gravity vector.
	b2Vec2 gravity;
	gravity.Set(0.0f, 0.0f);
	
	// Do we want to let bodies sleep?
	// This will speed up the physics simulation
	bool doSleep = false;
	
	// Construct a world object, which will hold and simulate the rigid bodies.
	world = new b2World(gravity, doSleep);
	
	world->SetContinuousPhysics(true);
	
	// Create contact listener
	contactListener = new ModeAContactListener();
	world->SetContactListener(contactListener);
	
	/*
	// Start Physics sim
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	[ [ NSRunLoop currentRunLoop ] addTimer:tickTimer forMode:NSDefaultRunLoopMode ];
	[ [ NSRunLoop currentRunLoop ] addTimer:tickTimer forMode:NSRunLoopCommonModes ];
	*/
	
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];

	
}

-(void) createEdgeWalls {
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	groundBody = world->CreateBody(&groundBodyDef);
	b2PolygonShape groundBox;		
	b2Fixture *fixture;		
	b2FixtureDef fixtureDef;
	CGSize screenSize = self.view.bounds.size;
	
	// bottom
	groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
	fixtureDef.shape = &groundBox;
	fixtureDef.filter.groupIndex = -8;
	fixture = groundBody->CreateFixture(&fixtureDef);
	
	// top
	groundBox.SetAsEdge(b2Vec2(0, (screenSize.height-44)/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO, (screenSize.height-44)/PTM_RATIO));
	fixtureDef.shape = &groundBox;
	fixtureDef.filter.groupIndex = -8;
	fixture = groundBody->CreateFixture(&fixtureDef);
	
	// left
	groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
	fixtureDef.shape = &groundBox;
	fixtureDef.filter.groupIndex = -8;
	fixture = groundBody->CreateFixture(&fixtureDef);
	
	// right
	groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));	
	fixtureDef.shape = &groundBox;
	fixtureDef.filter.groupIndex = -8;
	fixture = groundBody->CreateFixture(&fixtureDef);
	
}

-(void)createWorldObjects  {
	
	CGSize screenSize = self.view.bounds.size;

	
	circleHalfNote = [[ShapeCircle alloc] initWithFrame:CGRectMake(screenSize.width/2, screenSize.height/2, 192, 192)];
	circleHalfNote.container = self.view;
	[circleHalfNote setCircleSize:CIRCLE_HALF_NOTE];
	[circleHalfNote setWorld:world withGroundBody:groundBody];
	//[circleHalfNote turnOn];
	
	circleQuarterNote = [[ShapeCircle alloc] initWithFrame:CGRectMake(screenSize.width/2, screenSize.height/2, 176, 176)];
	circleQuarterNote.container = self.view;
	[circleQuarterNote setCircleSize:CIRCLE_QUARTER_NOTE];
	[circleQuarterNote setWorld:world withGroundBody:groundBody];
	[circleQuarterNote turnOn];
	
	circleEighthNote = [[ShapeCircle alloc] initWithFrame:CGRectMake(screenSize.width/2, screenSize.height/2, 160, 160)];
	circleEighthNote.container = self.view;
	[circleEighthNote setCircleSize:CIRCLE_EIGHTH_NOTE];
	[circleEighthNote setWorld:world withGroundBody:groundBody];
	[circleEighthNote turnOn];
 
}

-(void) createCorners {
	
	CGSize screenSize = self.view.bounds.size;
	int cornerWidth = 182;
	int cornerHeight = 278;
	
	cornerA = [[ModeACorner alloc] initWithFrame:CGRectMake(0, 44, cornerWidth, cornerHeight)];
	[self.view addSubview:cornerA];
	[cornerA setCornerType:CORNER_TOPLEFT];
	[cornerA setWorld:world];
	 
	cornerB = [[ModeACorner alloc] initWithFrame:CGRectMake(96*8-cornerWidth, 44, cornerWidth, cornerHeight)];
	[self.view addSubview:cornerB];
	[cornerB setCornerType:CORNER_TOPRIGHT];
	[cornerB setWorld:world];
	
	// Bottom
	
	cornerWidth = 168;
	
	cornerC = [[ModeACorner alloc] initWithFrame:CGRectMake(0, 44 + (96*10) - cornerHeight, cornerWidth, cornerHeight)];
	[self.view addSubview:cornerC];
	[cornerC setCornerType:CORNER_BOTLEFT];
	[cornerC setWorld:world];
	 
	cornerD = [[ModeACorner alloc] initWithFrame:CGRectMake(96*8-cornerWidth, 44 + (96*10) - cornerHeight, cornerWidth, cornerHeight)];
	[self.view addSubview:cornerD];
	[cornerD setCornerType:CORNER_BOTRIGHT];
	[cornerD setWorld:world];
	
	cornerHeight = 145;
	
	bottomBlock = [[BottomBlock alloc] initWithFrame:CGRectMake(cornerWidth, 44 + (96*10) - cornerHeight, 432, cornerHeight)];
	[self.view addSubview:bottomBlock];
	[bottomBlock setWorld:world withGroundBody:groundBody];
	 
}

-(void) tick:(NSTimer *)timer
{
	
	[keyboardTop update];
	//[keyboardBot update];
	[keyboardLeft update];
	[keyboardRight update];

	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
		
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(1.0f/60.0f, velocityIterations, positionIterations);
	
	CGSize screenSize = self.view.bounds.size;
	//NSLog(@"tick: screenSize: %f %f", screenSize.width, screenSize.height);
	
	//Iterate over bodies in physics world and update their UIView's position and rotation
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) 
		{
			UIView *oneView = (UIView *)b->GetUserData();
			// y Position subtracted because of flipped coordinate system
			CGPoint newCenter = CGPointMake(b->GetPosition().x * PTM_RATIO, screenSize.height - b->GetPosition().y * PTM_RATIO);
			oneView.center = newCenter;
			CGAffineTransform transform = CGAffineTransformMakeRotation(- b->GetAngle());
			oneView.transform = transform;
		}	
	}
	
	// Check for collisions
	std::vector<MyContact>::iterator pos;
	for(pos = contactListener->_contacts.begin(); pos != contactListener->_contacts.end(); ++pos) {
		MyContact contact = *pos;
		//NSLog(@"maxImpulse: %f", contact.impulse);
		
		int vel = ceil((contact.impulse / 2300) * 127);
		if (vel > 127) { vel = 127; }
		if (vel < 1)   { vel = 10; }
		
		bool isQuarterNote = NO;
		bool isHalfNote = NO;
		bool isEighthNote = NO;
		
		for (NoteBlock *noteblock in noteBlocks) {
			
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == circleQuarterNote.fixture) || (contact.fixtureA == circleQuarterNote.fixture && contact.fixtureB == noteblock.fixture)) {
				// Triggers animation and send message to MIDI controller
				[noteblock playNote:0 withVelocity:vel];
				circleQuarterNote.noteValue = noteblock.noteValue;
				[circleQuarterNote playNote:noteblock.noteValue withVelocity:vel];
				isQuarterNote = YES;
			}
			
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == circleHalfNote.fixture) || (contact.fixtureA == circleHalfNote.fixture && contact.fixtureB == noteblock.fixture)) {
				// Triggers animation and send message to MIDI controller
				[noteblock playNote:0 withVelocity:vel];
				circleHalfNote.noteValue = noteblock.noteValue;				
				[circleHalfNote playNote:noteblock.noteValue withVelocity:vel];
				isHalfNote = YES;
			}
						
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == circleEighthNote.fixture) || (contact.fixtureA == circleEighthNote.fixture && contact.fixtureB == noteblock.fixture)) {
				// Triggers animation and send message to MIDI controller
				[noteblock playNote:0 withVelocity:vel];
				circleEighthNote.noteValue = noteblock.noteValue;
				[circleEighthNote playNote:noteblock.noteValue withVelocity:vel];
				isEighthNote = YES;
			}
			
		}
		
		
		if (contact.fixtureA == circleQuarterNote.fixture  || contact.fixtureB == circleQuarterNote.fixture) {
			if (isQuarterNote == NO) {
				[circleQuarterNote playNote:circleQuarterNote.noteValue withVelocity:vel];
			}
		}
		
		if (contact.fixtureA == circleHalfNote.fixture  || contact.fixtureB == circleHalfNote.fixture) {
			if (isHalfNote == NO) {
				[circleHalfNote playNote:circleHalfNote.noteValue withVelocity:vel];
			}
		}
		
		if (contact.fixtureA == circleEighthNote.fixture  || contact.fixtureB == circleEighthNote.fixture) {
			if (isHalfNote == NO) {
				[circleEighthNote playNote:circleEighthNote.noteValue withVelocity:vel];
			}
		}
		
		
		if (bottomBlock.isOn) {
			
			
			// Bottom block checks
			float bottomForceX = 50;
			float bottomForceY = 3500;
			if ((contact.fixtureA == bottomBlock.fixture && contact.fixtureB == circleQuarterNote.fixture) || (contact.fixtureA == circleQuarterNote.fixture && contact.fixtureB == bottomBlock.fixture)) {
				[bottomBlock playNote];
				b2Vec2 force = b2Vec2(bottomForceX, bottomForceY);
				circleQuarterNote.body->ApplyLinearImpulse(force, circleQuarterNote.body->GetPosition());
			}
			
			if ((contact.fixtureA == bottomBlock.fixture && contact.fixtureB == circleHalfNote.fixture) || (contact.fixtureA == circleHalfNote.fixture && contact.fixtureB == bottomBlock.fixture)) {
				[bottomBlock playNote];
				b2Vec2 force = b2Vec2(bottomForceX, bottomForceY);
				circleHalfNote.body->ApplyLinearImpulse(force, circleHalfNote.body->GetPosition());
			}
			
			if ((contact.fixtureA == bottomBlock.fixture && contact.fixtureB == circleEighthNote.fixture) || (contact.fixtureA == circleEighthNote.fixture && contact.fixtureB == bottomBlock.fixture)) {
				[bottomBlock playNote];
				b2Vec2 force = b2Vec2(bottomForceX, bottomForceY);
				circleEighthNote.body->ApplyLinearImpulse(force, circleEighthNote.body->GetPosition());
			}
			
			
		}
		
	}
	
	// Clean up
	contactListener->_contacts.clear();		
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	b2Vec2 gravity;
	gravity.Set( acceleration.x * 9.81,  acceleration.y * 9.81 );
	
	world->SetGravity(gravity);
}





// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	
	[tickTimer invalidate], tickTimer = nil;
	[super dealloc];
}



@end
