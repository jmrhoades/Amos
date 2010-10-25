//
//  NoteBallA.m
//  Amos
//
//  Created by Justin Rhoades on 10/16/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "NoteBall.h"
#import "ModeAViewController.h"


@implementation NoteBall

@synthesize touchJoint;
@synthesize fixture;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
		[panGesture setMaximumNumberOfTouches:2];
		[panGesture setDelegate:self];
		[self addGestureRecognizer:panGesture];
		[panGesture release];
				
		base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_base.png"]];
		base.backgroundColor = [UIColor clearColor];
		base.opaque = NO;
		[self addSubview:base];
		
		outerRing = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_outer_ring_default.png"]];
		outerRing.backgroundColor = [UIColor clearColor];
		outerRing.opaque = NO;
		[self addSubview:outerRing];
		
		outerRingPanning = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_outer_ring_panning.png"]];
		outerRingPanning.backgroundColor = [UIColor clearColor];
		outerRingPanning.opaque = NO;
		[self addSubview:outerRingPanning];
		outerRingPanning.alpha = 0;
		
		innerRing = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_inner_ring_default.png"]];
		innerRing.backgroundColor = [UIColor clearColor];
		innerRing.opaque = NO;
		[self addSubview:innerRing];
		
		innerRingContact = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_inner_ring_contact.png"]];
		innerRingContact.backgroundColor = [UIColor clearColor];
		innerRingContact.opaque = NO;
		[self addSubview:innerRingContact];
		innerRingContact.alpha = 0;
		
		centerDisc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_center_default.png"]];
		centerDisc.backgroundColor = [UIColor clearColor];
		centerDisc.opaque = NO;
		[self addSubview:centerDisc];
		
		note = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_note_quarter.png"]];
		note.backgroundColor = [UIColor clearColor];
		note.opaque = NO;
		[self addSubview:note];
		
		shine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amos_circle_shine.png"]];
		shine.backgroundColor = [UIColor clearColor];
		shine.opaque = NO;
		[self addSubview:shine];
		
    }
    return self;
}

- (void)setWorld:(b2World *)aWorld withGroundBody:(b2Body *)aGroundBody {
	
	world = aWorld;	
	groundBody = aGroundBody;
	
	bodyDef.type = b2_dynamicBody;
	CGPoint p = self.center;
	CGRect screen = [[UIScreen mainScreen] bounds];
	
	// TEMP
	screen.size.height = screen.size.height - 64;
	NSLog(@"Ball screenSize: %f %f", screen.size.width, screen.size.height);
	
	bodyDef.position.Set(p.x/PTM_RATIO, (screen.size.height-p.y)/PTM_RATIO);
	bodyDef.userData = self;
	body = world->CreateBody(&bodyDef);		

	b2CircleShape shape;
	shape.m_radius = 80/PTM_RATIO;
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;	
	fixtureDef.density = 3.0f;
	fixtureDef.friction = 0.3f;
	fixtureDef.restitution = 0.95f; // 0 is a lead ball, 1 is a super bouncy ball
	self.fixture = body->CreateFixture(&fixtureDef);
}


- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *uiView = [gestureRecognizer view];
	
	if (uiView == self) {
		
		CGPoint touchLocation = [gestureRecognizer locationInView:self.superview];
		CGPoint location = [self convertToGL:touchLocation];
		b2Vec2  locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);		
		
		if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {	
			
			b2MouseJointDef md;
			md.bodyA = groundBody;
			md.bodyB = body;
			md.target = locationWorld;
			md.collideConnected = true;
			md.maxForce = 350.0f * body->GetMass();
			if (self.touchJoint != NULL) {						
				world->DestroyJoint(self.touchJoint);
				self.touchJoint = NULL;
			}
			self.touchJoint = (b2MouseJoint *)world->CreateJoint(&md);
			
			[UIView animateWithDuration:.33
								  delay:0
								options:UIViewAnimationOptionAllowUserInteraction
							 animations:^{ 
								 outerRingPanning.alpha = 1;
							 }
							 completion:^(BOOL finished){
								 ;}];
								 
		}
		if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
			// NSLog(@"Moved %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);
			if (self.touchJoint != NULL) {
				self.touchJoint->SetTarget(locationWorld);
			}
		}
		if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled) {
			// NSLog(@"End %f,%f -> %f,%f\n",touchLocation.x,touchLocation.y,locationWorld.x,locationWorld.y);		
			if (self.touchJoint != NULL) {
				world->DestroyJoint(self.touchJoint);
				self.touchJoint = NULL;
				
				[UIView animateWithDuration:.83
									  delay:0
									options:UIViewAnimationOptionAllowUserInteraction
								 animations:^{ 
									 outerRingPanning.alpha = 0;
								 }
								 completion:^(BOOL finished){
									 ;}];
				
			}
		}	
			
	}

}

	
	


-(CGPoint)convertToGL:(CGPoint)uiPoint
{
	CGSize s = self.superview.bounds.size;
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


- (void)playNote:(int)note withVelocity:(int)vel {
	
	//NSLog(@"Note ball hit Hit!");
	
	[UIView animateWithDuration:.01
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{ 
						 innerRingContact.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:.66
											   delay:0
											 options:UIViewAnimationOptionAllowUserInteraction
										  animations:^{
											  innerRingContact.alpha = 0;
										  }
										  completion:^(BOOL finished){
											  ;
										  }
						  ];}];
	
	
		
}




- (void)dealloc {
    [super dealloc];
}


@end
