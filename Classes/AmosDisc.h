//
//  AmosDisc.h
//  Amos
//
//  Created by Justin Rhoades on 1/7/11.
//  Copyright 2011 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeBase.h"

@interface AmosDisc : ShapeBase  {
	
	NSString *circleSize; 
	bool isConfigOpen;
}

@property (nonatomic, retain) NSString *circleSize;
@property (nonatomic) bool isConfigOpen;


- (void) setCircleSize:(NSString *)circSize;


@end