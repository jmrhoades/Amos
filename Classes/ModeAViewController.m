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

	self.view.backgroundColor = [UIColor whiteColor];
	
	[self createPhysicsWorld];
		
	CGRect screen = [[UIScreen mainScreen] bounds];

	noteblocks = [[NSMutableArray alloc] init];
	
	cornerA = [[ModeACorner alloc] initWithFrame:CGRectMake(0, 0, 128.0, 128.0)];
	[self.view addSubview:cornerA];
	[cornerA setCornerType:CORNER_TOPLEFT];
	[cornerA setWorld:world];
	
	cornerB = [[ModeACorner alloc] initWithFrame:CGRectMake(screen.size.width-128, 0, 128.0, 128.0)];
	[self.view addSubview:cornerB];
	[cornerB setCornerType:CORNER_TOPRIGHT];
	[cornerB setWorld:world];
	
	cornerC = [[ModeACorner alloc] initWithFrame:CGRectMake(screen.size.width-128, screen.size.height-128, 128.0, 128.0)];
	[self.view addSubview:cornerC];
	[cornerC setCornerType:CORNER_BOTRIGHT];
	[cornerC setWorld:world];
	
	cornerD = [[ModeACorner alloc] initWithFrame:CGRectMake(0, screen.size.height-128, 128.0, 128.0)];
	[self.view addSubview:cornerD];
	[cornerD setCornerType:CORNER_BOTLEFT];
	[cornerD setWorld:world];
	
	
	// Create top row of note blocks
	int numWide = 8;
	int numTall = 12;
	
	for (int i = 0; i < numWide; i++) {
		[self addNoteBlock:BLOCK_TOP forIndex:i];
		[self addNoteBlock:BLOCK_BOT forIndex:i];
	}
	
	// Create right side row of note blocks
	for (int i = 0; i < numTall; i++) {
		[self addNoteBlock:BLOCK_RIGHT forIndex:i];
		[self addNoteBlock:BLOCK_LEFT forIndex:i];
	}
	
	UIPanGestureRecognizer *panGestureBallA = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBallA:)];
	[panGestureBallA setMaximumNumberOfTouches:2];
	[panGestureBallA setDelegate:self];
	ballA = [[NoteBall alloc] initWithFrame:CGRectMake(500, 500, 128.0, 128.0)];
	[self.view addSubview:ballA];
	[ballA addGestureRecognizer:panGestureBallA];
	[ballA setWorld:world];
	[panGestureBallA release];
	
	UIPanGestureRecognizer *panGestureBallB = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBallB:)];
	[panGestureBallB setMaximumNumberOfTouches:2];
	[panGestureBallB setDelegate:self];
	ballB = [[NoteBall alloc] initWithFrame:CGRectMake(200, 200, 192.0, 192.0)];
	[self.view addSubview:ballB];
	[ballB addGestureRecognizer:panGestureBallB];
	[ballB setWorld:world];
	[panGestureBallB release];
	
	UIPanGestureRecognizer *panGestureBallC = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBallC:)];
	[panGestureBallC setMaximumNumberOfTouches:2];
	[panGestureBallC setDelegate:self];
	ballC = [[NoteBall alloc] initWithFrame:CGRectMake(100, 100, 96.0, 96.0)];
	[self.view addSubview:ballC];
	[ballC addGestureRecognizer:panGestureBallC];
	[ballC setWorld:world];	
	[panGestureBallC release];
	 
	
	for (UIView *uiView in self.view.subviews)
	{
		//[self addPhysicalBodyForView:uiView];
	}
	
	// Create contact listener
	contactListener = new ModeAContactListener();
	world->SetContactListener(contactListener);
	
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	 
	/*
	//Configure and start accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60.0)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	 */
	
	// ***  Initialize DSMI
	//**********************
	//libdsmi=[[libdsmi_iphone alloc] init];
	// ***************
	
}

-(void) addNoteBlock:(NSString *)typeName forIndex:(int)i {
	CGRect screen = [[UIScreen mainScreen] bounds];
	CGRect blockFrame;
	
	if ([typeName isEqualToString:BLOCK_RIGHT]) {
		blockFrame = CGRectMake(screen.size.width-96.0, 128.0 + (i*64.0), 96.0, 64.0);
	}
	
	if ([typeName isEqualToString:BLOCK_LEFT]) {
		blockFrame = CGRectMake(0.0, 128.0 + (i*64.0), 96.0, 64.0);
	}
	
	if ([typeName isEqualToString:BLOCK_BOT]) {
		blockFrame = CGRectMake(128.0 + (i*64.0), screen.size.height-96.0, 64.0, 96.0);
	}
	
	if ([typeName isEqualToString:BLOCK_TOP]) {
		blockFrame = CGRectMake(128.0 + (i*64.0), 0, 64.0, 96.0);
	}
	
	ModeANoteBlock *note = [[ModeANoteBlock alloc] initWithFrame:blockFrame];
	[note setBlockType:typeName];
	[self.view addSubview:note];
	[note setWorld:world];		
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
	[ballA release];
	[ballB release];
	[tickTimer invalidate], tickTimer = nil;
	[super dealloc];
}

-(void)createPhysicsWorld 
{
	CGSize screenSize = self.view.bounds.size;
	
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
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
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

-(void)addPhysicalBodyForView:(UIView *)uiView
{
	if (uiView == cornerA) {
				
	} 
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
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) 
		{
			UIView *oneView = (UIView *)b->GetUserData();
			
			// y Position subtracted because of flipped coordinate system
			CGPoint newCenter = CGPointMake(b->GetPosition().x * PTM_RATIO, self.view.bounds.size.height - b->GetPosition().y * PTM_RATIO);
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
				if(vel > 20) {
					[noteblock playNote:0 withVelocity:vel];
				}
			}
			
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == ballB.fixture) || (contact.fixtureA == ballB.fixture && contact.fixtureB == noteblock.fixture)) {
				int vel = ceil((contact.impulse / 8000) * 127);
				if (vel > 127) { vel = 127; }
				if(vel > 20) {
					[noteblock playNote:0 withVelocity:vel];
				}
			}
			
			if ((contact.fixtureA == noteblock.fixture && contact.fixtureB == ballC.fixture) || (contact.fixtureA == ballC.fixture && contact.fixtureB == noteblock.fixture)) {
				int vel = ceil((contact.impulse / 1000) * 127);
				if (vel > 127) { vel = 127; }
				if(vel > 20) {
					[noteblock playNote:0 withVelocity:vel];
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

- (void)panBallA:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *uiView = [gestureRecognizer view];
	CGPoint touchLocation = [gestureRecognizer locationInView:self.view];
	CGPoint location = [self convertToGL:touchLocation];
	b2Vec2  locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
	// Loop through each body in physics simulation and check for contact
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {		
		// NSLog(@"Touched %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
			if (b->GetUserData() != NULL) {
				UIView *oneView = (UIView *)b->GetUserData();
				if (oneView == uiView) {
					b2MouseJointDef md;
					md.bodyA = groundBody;
					md.bodyB = b;
					md.target = locationWorld;
					md.collideConnected = true;
					md.maxForce = 350.0f * b->GetMass();
					if (uiView == ballA) {	
						if (ballA.touchJoint != NULL) {						
							world->DestroyJoint(ballA.touchJoint);
							ballA.touchJoint = NULL;
						}
						ballA.touchJoint = (b2MouseJoint *)world->CreateJoint(&md);
					}
				}
			}
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
		// NSLog(@"Moved %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		if (ballA.touchJoint != NULL) {
			ballA.touchJoint->SetTarget(locationWorld);
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled) {
		// NSLog(@"End %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);		
		if (ballA.touchJoint != NULL) {
			world->DestroyJoint(ballA.touchJoint);
			ballA.touchJoint = NULL;
		}
	}
}

- (void)panBallB:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *uiView = [gestureRecognizer view];
	CGPoint touchLocation = [gestureRecognizer locationInView:self.view];
	CGPoint location = [self convertToGL:touchLocation];
	b2Vec2  locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
	// Loop through each body in physics simulation and check for contact
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {		
		// NSLog(@"Touched %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
			if (b->GetUserData() != NULL) {
				UIView *oneView = (UIView *)b->GetUserData();
				if (oneView == uiView) {
					b2MouseJointDef md;
					md.bodyA = groundBody;
					md.bodyB = b;
					md.target = locationWorld;
					md.collideConnected = true;
					md.maxForce = 350.0f * b->GetMass();
					if (uiView == ballB) {	
						if (ballB.touchJoint != NULL) {						
							world->DestroyJoint(ballB.touchJoint);
							ballB.touchJoint = NULL;
						}
						ballB.touchJoint = (b2MouseJoint *)world->CreateJoint(&md);
					}
				}
			}
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
		// NSLog(@"Moved %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		if (ballB.touchJoint != NULL) {
			ballB.touchJoint->SetTarget(locationWorld);
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled) {
		// NSLog(@"End %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);		
		if (ballB.touchJoint != NULL) {
			world->DestroyJoint(ballB.touchJoint);
			ballB.touchJoint = NULL;
		}
	}
}

- (void)panBallC:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *uiView = [gestureRecognizer view];
	CGPoint touchLocation = [gestureRecognizer locationInView:self.view];
	CGPoint location = [self convertToGL:touchLocation];
	b2Vec2  locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
	// Loop through each body in physics simulation and check for contact
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {		
		// NSLog(@"Touched %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
			if (b->GetUserData() != NULL) {
				UIView *oneView = (UIView *)b->GetUserData();
				if (oneView == uiView) {
					b2MouseJointDef md;
					md.bodyA = groundBody;
					md.bodyB = b;
					md.target = locationWorld;
					md.collideConnected = true;
					md.maxForce = 350.0f * b->GetMass();
					if (uiView == ballC) {	
						if (ballC.touchJoint != NULL) {						
							world->DestroyJoint(ballC.touchJoint);
							ballC.touchJoint = NULL;
						}
						ballC.touchJoint = (b2MouseJoint *)world->CreateJoint(&md);
					}
				}
			}
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
		// NSLog(@"Moved %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
		if (ballC.touchJoint != NULL) {
			ballC.touchJoint->SetTarget(locationWorld);
		}
	}
	if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled) {
		// NSLog(@"End %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);		
		if (ballC.touchJoint != NULL) {
			world->DestroyJoint(ballC.touchJoint);
			ballC.touchJoint = NULL;
		}
	}
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
