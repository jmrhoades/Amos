//
//  NoteSettingsTableViewController.h
//  AmosUIView
//
//  Created by Justin Rhoades on 11/3/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NoteSettingsTableViewController : UITableViewController {
	NSMutableArray *noteSettings;

}

@property (nonatomic, retain) NSMutableArray *noteSettings;

- (void)switchAction:(UISwitch*)sender;

@end
