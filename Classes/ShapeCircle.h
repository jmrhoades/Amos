//
//  ShapeCircle.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/6/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeBase.h"

@interface ShapeCircle : ShapeBase  {
	
	NSString *circleSize; 
	
}

@property (nonatomic, retain) NSString *circleSize;

- (void) setCircleSize:(NSString *)circSize;


@end
