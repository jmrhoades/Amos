//
//  AmosViewController.m
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "ModeAViewController.h"
#import "NoteBall.h"
#import "ModeACorner.h"
#import "ModeANoteBlock.h"

@implementation ModeAViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	// Background
	UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_background_01.png"]];
	[self.view addSubview:background];
	[background release];
	
	// TEMP Top
	UIImageView *temp_top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"temp_top_768x43.png"]];
	[self.view addSubview:temp_top];
	[temp_top release];
	
	[self createPhysicsWorld];
	
	[self createWorldObjects];
	
	/*
	 //Configure and start accelerometer
	 [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60.0)];
	 [[UIAccelerometer sharedAccelerometer] setDelegate:self];
	 */
	
}

-(void) addNoteBlock:(NSString *)typeName forIndex:(int)i {
	CGRect blockFrame;
	CGSize screenSize = self.view.bounds.size;
	int topOffset = 44;
	screenSize.height = screenSize.height - topOffset;	
	// TEMP - SHOULD BE BASED ON ORIENTATION, NOT FIXED
	// Need to account for Top Tool Bar Height
	int worldSize = 96;
	int assetSize = 128;
	int sizeOffset = (assetSize - worldSize) / 2;
	NSLog(@"addNoteBlock: screenSize: %f %f", screenSize.width, screenSize.height);
	
	if ([typeName isEqualToString:BLOCK_RIGHT]) {
		blockFrame = CGRectMake( screenSize.width-sizeOffset-worldSize, topOffset-sizeOffset + worldSize + (i*worldSize), assetSize, assetSize);
	}
	
	if ([typeName isEqualToString:BLOCK_LEFT]) {
		blockFrame = CGRectMake( -sizeOffset, topOffset-sizeOffset + worldSize + (i*worldSize), assetSize, assetSize);
	}
	
	if ([typeName isEqualToString:BLOCK_BOT]) {
		blockFrame = CGRectMake( (worldSize - sizeOffset) + (i*worldSize), (topOffset + screenSize.height) - assetSize + sizeOffset, assetSize, assetSize);
	}
	
	if ([typeName isEqualToString:BLOCK_TOP]) {
		blockFrame = CGRectMake( (worldSize - sizeOffset) + (i*worldSize), topOffset-sizeOffset, assetSize, assetSize);
	}
	
	ModeANoteBlock *note = [[ModeANoteBlock alloc] initWithFrame:blockFrame];
	[self.view addSubview:note];
	[note setBlockType:typeName];
	[note setNoteValue:i];
	[note setWorld:world withGroundBody:groundBody];
	[noteblocks addObject:note];
	
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

-(void)createPhysicsWorld  {
	
	CGSize screenSize = self.view.bounds.size;
	// TEMP - SHOULD BE BASED ON ORIENTATION, NOT FIXED
	// Need to account for Top Tool Bar Height
	screenSize.height = screenSize.height - 44;
	
	NSLog(@"createPhysicsWorld: screenSize: %f %f", screenSize.width, screenSize.height);
	
	
	// Define the gravity vector.
	b2Vec2 gravity;
	gravity.Set(0.0f, 0.0f);
	
	// Do we want to let bodies sleep?
	// This will speed up the physics simulation
	bool doSleep = false;
	
	// Construct a world object, which will hold and simulate the rigid bodies.
	world = new b2World(gravity, doSleep);
	
	world->SetContinuousPhysics(true);
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, -32/PTM_RATIO); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2PolygonShape groundBox;		
	
	// bottom
	groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox, 0);
	
	// top
	groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox, 0);
	
	// left
	groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox, 0);
	
	// right
	groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox, 0);
	
}

-(void)createWorldObjects  {
	
	CGSize screenSize = self.view.bounds.size;
	// TEMP - SHOULD BE BASED ON ORIENTATION, NOT FIXED
	// Need to account for Top Tool Bar Height
	int worldSize = 96;
	int assetSize = 128;
	int topOffset = 44;
	int sizeOffset = (assetSize - worldSize) / 2;
	screenSize.height = screenSize.height - topOffset;
	int bottomY = (topOffset + screenSize.height) - assetSize + sizeOffset;
	int leftX = screenSize.width-sizeOffset-worldSize;
	NSLog(@"createWorldObjects: screenSize: %f %f", screenSize.width, screenSize.height);
	
	NSLog(@"bottomY: %i leftX: %i", bottomY, leftX);
	
	noteblocks = [[NSMutableArray alloc] init];
	

	
	ballA = [[NoteBall alloc] initWithFrame:CGRectMake(500, 500, 200.0, 200.0)];
	[self.view addSubview:ballA];
	[ballA setWorld:world withGroundBody:groundBody];
	
	
	// Create top row of note blocks
	int numWide = 6;
	int numTall = 8;
	
	for (int i = 0; i < numWide; i++) {
		[self addNoteBlock:BLOCK_TOP forIndex:i];
		[self addNoteBlock:BLOCK_BOT forIndex:i];
	}
	
	// Create right side row of note blocks
	for (int i = 0; i < numTall; i++) {
		[self addNoteBlock:BLOCK_RIGHT forIndex:i];
		[self addNoteBlock:BLOCK_LEFT forIndex:i];
	}
	
	cornerA = [[ModeACorner alloc] initWithFrame:CGRectMake(-sizeOffset, topOffset-sizeOffset, assetSize, assetSize)];
	[self.view addSubview:cornerA];
	[cornerA setCornerType:CORNER_TOPLEFT];
	[cornerA setWorld:world];
	
	cornerB = [[ModeACorner alloc] initWithFrame:CGRectMake(leftX, topOffset-sizeOffset, assetSize, assetSize)];
	[self.view addSubview:cornerB];
	[cornerB setCornerType:CORNER_TOPRIGHT];
	[cornerB setWorld:world];
	
	cornerC = [[ModeACorner alloc] initWithFrame:CGRectMake(leftX, bottomY, assetSize, assetSize)];
	[self.view addSubview:cornerC];
	[cornerC setCornerType:CORNER_BOTRIGHT];
	[cornerC setWorld:world];
	
	cornerD = [[ModeACorner alloc] initWithFrame:CGRectMake(-sizeOffset, bottomY, assetSize, assetSize)];
	[self.view addSubview:cornerD];
	[cornerD setCornerType:CORNER_BOTLEFT];
	[cornerD setWorld:world];
	
	// Create contact listener
	contactListener = new ModeAContactListener();
	world->SetContactListener(contactListener);
	
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void)addPhysicalBodyForView:(UIView *)uiView
{
	
}

-(void) tick:(NSTimer *)timer
{
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
	// TEMP - SHOULD BE BASED ON ORIENTATION, NOT FIXED
	// Need to account for Top Tool Bar Height
	screenSize.height = screenSize.height - 24;
	
	//NSLog(@"tick: screenSize: %f %f", screenSize.width, screenSize.height);
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) 
		{
			UIView *oneView = (UIView *)b->GetUserData();
			
			if ([oneView isKindOfClass:[ModeACorner class]]) {
				
			} else {
				
				
			}
			
			
			// y Position subtracted because of flipped coordinate system
			CGPoint newCenter = CGPointMake(b->GetPosition().x * PTM_RATIO, screenSize.height - b->GetPosition().y * PTM_RATIO);
			oneView.center = newCenter;
			
			CGAffineTransform transform = CGAffineTransformMakeRotation(- b->GetAngle());
			
			oneView.transform = transform;
			
			
		}	
	}
	
	std::vector<MyContact>::iterator pos;
	
	for(pos = contactListener->_contacts.begin(); pos != contactListener->_contacts.end(); ++pos) {
		MyContact contact = *pos;
		NSLog(@"maxImpulse: %f", contact.impulse);
		
		
		for (ModeANoteBlock *noteblock in noteblocks) {
			
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == ballA.fixture) || (contact.fixtureA == ballA.fixture && contact.fixtureB == noteblock.fixture)) {
				int vel = ceil((contact.impulse / 1500) * 127);
				if (vel > 127) { vel = 127; }
				if(vel > 10) {
					
					[noteblock playNote:0 withVelocity:vel];
					[ballA playNote:0 withVelocity:vel];
					[self.view bringSubviewToFront:noteblock];
				}
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





-(CGPoint)convertToGL:(CGPoint)uiPoint
{
	CGSize s = self.view.bounds.size;
	float newY = s.height - uiPoint.y;
	float newX = s.width - uiPoint.x;
	CGPoint ret = CGPointZero;
	switch ( [[UIDevice currentDevice] orientation] ) {
		case UIDeviceOrientationPortrait:
			ret = CGPointMake(uiPoint.x, newY);
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			ret = CGPointMake(newX, uiPoint.y);
			break;
		case UIDeviceOrientationLandscapeLeft:
			ret.x = uiPoint.y;
			ret.y = uiPoint.x;
			break;
		case UIDeviceOrientationLandscapeRight:
			ret.x = newY;
			ret.y = newX;
			break;
	}
	return ret;
}


@end
