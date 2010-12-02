//
//  NoteSetting.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/4/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NoteSetting : NSObject {

	NSString *label;
	int value;
	bool isOn;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic) int value;
@property (nonatomic) bool isOn;



@end
