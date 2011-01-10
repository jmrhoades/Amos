//
//  SettingsViewController.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/3/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "SettingsViewController.h"
#import "NoteSettingsTableViewController.h"
#import "AmosAppDelegate.h"
#import "AmosMIDIManager.h"
#import "NoteSetting.h"
#import "ModeAViewController.h"
#import "ShapeBase.h"
#import "AmosDisc.h"
#import "DSMIDIInfoViewController.h"
#import "PYMIDIManager.h"
#import "PYMIDIEndpoint.h"
#import "MIDIChannelWiFi.h"
#import "MIDIChannelUSB.h"
#import "MIDIMobilizerChannel.h"


@implementation SettingsViewController



enum Sections {
    kKeyboardsSection = 0,
    kDiscsSection,
    kMIDIOutSection,
    kBPMSection,
    NUM_SECTIONS
};

enum KeyboardsSectionRows {
    kKeyboardsSectionNotesRow = 0,
    kKeyboardsSectionOctaveCountRow,
    kKeyboardsSectionOctaveStartRow,
    NUM_KEYBOARD_SECTION_ROWS
};

enum DiscsSectionRows {
    kDiscsSectionHalfNoteRow = 0,
    kDiscsSectionQuarterNoteRow,
    kDiscsSectionEigthNoteRow,
    NUM_DISCS_SECTION_ROWS
};

enum MIDIOutSectionRows {
    kMIDIOutDSMIRow = 0,
    kMIDIOutCoreMIDIRow,
	kMIDIOutMIDIMobilizerRow,
    NUM_MIDI_OUT_SECTION_ROWS
};

enum BPMSectionRows {
    kBPMSectionBPMRow = 0,
    NUM_BPM_SECTION_ROWS
};


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    self = [ super initWithStyle: UITableViewStyleGrouped ];
    if (self) {
        self.title = @"Settings";
		
		
		
		UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350, 20)];
		footerView.backgroundColor = [UIColor clearColor];
		footerView.opaque = NO;
		UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, 350, 20)];
		footerLabel.backgroundColor = [UIColor clearColor];
		footerLabel.opaque = NO;
		footerLabel.textAlignment = UITextAlignmentCenter;
		footerLabel.font = [UIFont systemFontOfSize:13.0];
		footerLabel.shadowColor = [UIColor colorWithRed:1.0*0/256 green:1.0*0/256 blue:1.0*0/256 alpha:.5];
		footerLabel.shadowOffset = CGSizeMake(0,-1);		[footerView addSubview:footerLabel];
		footerLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.35];
		footerLabel.text = @"Amos 1.1";		
		self.tableView.tableFooterView = footerView;
		[footerView release];
		
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiSetupChanged) name:@"PYMIDISetupChanged" object:nil];
		
		
    }
    return self;
}

-(void) midiSetupChanged {
	[self.tableView reloadData];
}



#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 4;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch(section) {
		case kKeyboardsSection:
			return NUM_KEYBOARD_SECTION_ROWS;
		case kDiscsSection:
			return NUM_DISCS_SECTION_ROWS;
		case kMIDIOutSection:
			return NUM_MIDI_OUT_SECTION_ROWS;
		case kBPMSection:
			return NUM_BPM_SECTION_ROWS;
		default:
			return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ], [ indexPath indexAtPosition:1 ]];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	AmosAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSMutableArray *noteSettings = appDelegate.midiManager.noteSettings;
	NoteSetting *setting;
	
	
	if(indexPath.section == kKeyboardsSection) {
		
		if (indexPath.row == kKeyboardsSectionNotesRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			NSString *label = @"";
			int count = 0;
			for (setting in noteSettings) {
				if (setting.isOn) {
					if (count == 0) {
						label = setting.label;
					} else {
						label = [NSString stringWithFormat:@"%@ %@",label, setting.label];
					}
					count++;
				}
			}
			cell.textLabel.text = @"Notes";
			cell.detailTextLabel.text = label;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			return cell; 
		}
		
		if (indexPath.row == kKeyboardsSectionOctaveCountRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			int octaveCount = [appDelegate.midiManager getOctaveCount];	
			cell.textLabel.text = @"Octave Count";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", octaveCount];
			octaveCountLabel = cell.detailTextLabel;
			UISlider *octaveCountControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(160, 0, 170, 45) ];
			octaveCountControl.minimumValue = 1.0;
			octaveCountControl.maximumValue = 9.0;
			octaveCountControl.tag = 0;
			octaveCountControl.value = octaveCount;
			octaveCountControl.continuous = YES;
			[octaveCountControl addTarget:self action:@selector(octaveCountAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: octaveCountControl];
			[octaveCountControl release];
			return cell;			
		}
		
		if (indexPath.row == kKeyboardsSectionOctaveStartRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			int octaveStart = [appDelegate.midiManager getOctaveStart];
			cell.textLabel.text = @"Octave Start";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", octaveStart];
			octaveStartLabel = cell.detailTextLabel;
			octaveStartControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(160, 0, 170, 45) ];
			octaveStartControl.minimumValue = 0.0;
			octaveStartControl.maximumValue = 9.0 - [appDelegate.midiManager getOctaveCount];
			octaveStartControl.tag = 0;
			octaveStartControl.value = octaveStart;
			octaveStartControl.continuous = YES;
			[octaveStartControl addTarget:self action:@selector(octaveStartAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: octaveStartControl];
			return cell;
		}
		
		
	}
	
	
	if(indexPath.section == kDiscsSection) {
		
		if (indexPath.row == kDiscsSectionHalfNoteRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = @"Half Note";
			UISwitch *resetControl = [[UISwitch alloc] initWithFrame: CGRectMake(265, 10, 0, 0) ];
			resetControl.on = appDelegate.modeA.discLarge.isOn;
			resetControl.tag = 1;
			[resetControl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: resetControl];
			[resetControl release];
			return cell;			
		}
		
		if (indexPath.row == kDiscsSectionQuarterNoteRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = @"Quarter Note";
			UISwitch *resetControl = [[UISwitch alloc] initWithFrame: CGRectMake(265, 10, 0, 0) ];
			resetControl.on = appDelegate.modeA.discMedium.isOn;
			resetControl.tag = 2;
			[resetControl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: resetControl];
			[resetControl release];
			return cell;			
		}
		
		if (indexPath.row == kDiscsSectionEigthNoteRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = @"Eighth Note";
			UISwitch *resetControl = [[UISwitch alloc] initWithFrame: CGRectMake(265, 10, 0, 0) ];
			resetControl.on = appDelegate.modeA.discSmall.isOn;
			resetControl.tag = 3;
			[resetControl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: resetControl];
			[resetControl release];
			return cell;			
		}
		
	}
	
	
	if(indexPath.section == kMIDIOutSection) {
		
		if (indexPath.row == kMIDIOutDSMIRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			cell.textLabel.text = @"DSMI";				
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Channel %i", appDelegate.midiManager.midiChannelWiFi + 1 ];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			return cell;
		}
		
		if (indexPath.row == kMIDIOutCoreMIDIRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			PYMIDIEndpoint *endpoint = [appDelegate.midiManager getMIDIEndPoint];
			if (endpoint != nil) {
				cell.textLabel.text = [endpoint displayName];
				cell.detailTextLabel.text = [NSString stringWithFormat:@"Channel %i", appDelegate.midiManager.midiChannelUSB + 1 ];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			} else {
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.textLabel.textColor = [UIColor lightGrayColor];	
				cell.textLabel.text = @"MIDI Device Not Connected";
			}
			return cell;			
		}
		
		if (indexPath.row == kMIDIOutMIDIMobilizerRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			
			if (appDelegate.midiManager.isMIDIMobilizerConnected) {
				cell.textLabel.text = @"MIDIMobilizer Connected";
				cell.detailTextLabel.text = [NSString stringWithFormat:@"Channel %i", appDelegate.midiManager.midiChannelMIDIMobilizer + 1 ];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			} else {
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.textLabel.textColor = [UIColor lightGrayColor];	
				cell.textLabel.text = @"MIDIMobilizer Not Connected";
			}
			return cell;			
		}
		
	}
	
	
	if(indexPath.section == kBPMSection) {
		
		if (indexPath.row == kBPMSectionBPMRow) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CellIdentifier] autorelease];
			cell.detailTextLabel.text = @"120";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			bpmLabel = cell.detailTextLabel;
			UISlider *bpmControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(20, 0, 300, 45) ];
			bpmControl.minimumValue = 60.0;
			bpmControl.maximumValue = 200.0;
			bpmControl.tag = 0;
			bpmControl.value = 120;
			bpmControl.continuous = YES;
			[bpmControl addTarget:self action:@selector(bpmSliderAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: bpmControl];
			[bpmControl release];
			return cell;			
		}

	}
	
    return cell;
	
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == kKeyboardsSection) {
		return @"Keyboards";
	}
	
	if(section == kDiscsSection) {
		return @"Discs";
	}	
    
	if(section == kMIDIOutSection) {
		return @"MIDI Out";
	}	
	
	if(section == kBPMSection) {
		return @"BPM";
	}

	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 45.0f;
	
}


- (void)switchAction:(UISwitch*)sender
{
	//NSLog(@"switchAction: sender = %d, isOn %d",  [sender tag], [sender isOn]);	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.modeA toggleShape:[sender tag] status:[sender isOn]];	
}



- (void)bpmSliderAction:(UISlider*)sender
{
	
	int val = round([sender value]);
	//NSLog(@"%i", val);
	bpmLabel.text = [NSString stringWithFormat:@"%i", val];
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager setBPM:val];	
	
}

- (void)octaveCountAction:(UISlider*)sender
{
	int val = round([sender value]);
	//NSLog(@"%i", val);
	octaveCountLabel.text = [NSString stringWithFormat:@"%i", val];
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager setOctaveCount:val];	
	
	int maxStartVal = 9 - [delegate.midiManager getOctaveCount];
	octaveStartControl.maximumValue = maxStartVal;
	if (octaveStartControl.value > maxStartVal) {
		octaveStartControl.value = maxStartVal;
		[delegate.midiManager setOctaveStart:val];	
		[self.tableView reloadData];
	}
	
	[delegate.modeA noteSettingsDidChange];
	

}

- (void)octaveStartAction:(UISlider*)sender
{
	int val = round([sender value]);
	//NSLog(@"%i", val);
	octaveStartLabel.text = [NSString stringWithFormat:@"%i", val];
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager setOctaveStart:val];	
	[delegate.modeA noteSettingsDidChange];	
}


#pragma mark -
#pragma mark Table view delegate







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if(indexPath.section == kKeyboardsSection) {
		
		if (indexPath.row == kKeyboardsSectionNotesRow) {
			[tableView deselectRowAtIndexPath:indexPath animated:NO];
			NoteSettingsTableViewController *notesController = [[NoteSettingsTableViewController alloc] init];
			notesController.contentSizeForViewInPopover = self.tableView.frame.size;
			[self.navigationController pushViewController:notesController animated:YES];
			[notesController release];
		}
		
	}
	
	
	if(indexPath.section == kMIDIOutSection) {
		
		if (indexPath.row == kMIDIOutDSMIRow) {
			[tableView deselectRowAtIndexPath:indexPath animated:NO];
			MIDIChannelWiFi *midiChannelSelect = [[MIDIChannelWiFi alloc] initWithStyle:UITableViewStyleGrouped];
			midiChannelSelect.contentSizeForViewInPopover = self.tableView.frame.size;
			[self.navigationController pushViewController:midiChannelSelect animated:YES];
			[midiChannelSelect release];
		}
		
		if (indexPath.row == kMIDIOutCoreMIDIRow) {
			[tableView deselectRowAtIndexPath:indexPath animated:NO];
			AmosAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
			PYMIDIEndpoint *endpoint = [appDelegate.midiManager getMIDIEndPoint];
			if (endpoint != nil) {
				MIDIChannelUSB *midiChannelSelect = [[MIDIChannelUSB alloc] initWithStyle:UITableViewStyleGrouped];
				midiChannelSelect.contentSizeForViewInPopover = self.tableView.frame.size;
				[self.navigationController pushViewController:midiChannelSelect animated:YES];
				[midiChannelSelect release];
			} 
		}
		
		
		if (indexPath.row == kMIDIOutMIDIMobilizerRow) {
			[tableView deselectRowAtIndexPath:indexPath animated:NO];
			AmosAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
			if (appDelegate.midiManager.isMIDIMobilizerConnected) {
				MIDIMobilizerChannel *midiChannelSelect = [[MIDIMobilizerChannel alloc] initWithStyle:UITableViewStyleGrouped];
				midiChannelSelect.contentSizeForViewInPopover = self.tableView.frame.size;
				[self.navigationController pushViewController:midiChannelSelect animated:YES];
				[midiChannelSelect release];
			} 
		}
		
		
		
		
		
	}
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}


- (void)dealloc {
    [super dealloc];
}


@end

