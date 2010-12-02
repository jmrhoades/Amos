//
//  ShapeBase.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/6/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>
#import "AmosUIViewBody.h"


@interface ShapeBase : AmosUIViewBody  {
	
	bool isOn;
	UIView *container;
	
	b2BodyDef bodyDef;
	b2FixtureDef fixtureDef;
	b2CircleShape circleShape;
	b2PolygonShape polygonShape;
	
	UIImageView *base;
	UIImageView *noteOn;
	UIImageView *panLight;

	float duration;

}

@property (nonatomic, retain) UIView *container;
@property (nonatomic) bool isOn;


-(void) turnOn;
-(void) turnOff;
-(void) playNote:(int)note withVelocity:(int)vel;
- (void)stopNoteByTimer:(NSTimer*)theTimer;


@end
