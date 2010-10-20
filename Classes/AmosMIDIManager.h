//
//  AmosMIDIManager.h
//  Amos
//
//  Created by Justin Rhoades on 10/19/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libdsmi_iphone.h"


@interface AmosMIDIManager : NSObject {
	libdsmi_iphone *libdsmi;

}

@property (nonatomic, retain) libdsmi_iphone *libdsmi;

- (void)playNote:(int)note withVelocity:(int)vel;
- (void)stopNoteByTimer:(NSTimer*)theTimer;


@end
