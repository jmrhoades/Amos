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
#import "ShapeCircle.h"
#import "DSMIDIInfoViewController.h"

@implementation SettingsViewController


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
		footerLabel.text = @"Amos 1.0";		
		self.tableView.tableFooterView = footerView;
		[footerView release];
		
		
		
    }
    return self;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
        case(0):
            return 1;
		break;
        case(1):
            return 3;
		break;
        case(2):
            return 1;
		break;
		case(3):
            return 1;
		break;
    }
	
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ], [ indexPath indexAtPosition:1 ]];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [ [ [ UITableViewCell alloc ] initWithFrame: CGRectZero reuseIdentifier: CellIdentifier] autorelease ];
	
	AmosAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSMutableArray *noteSettings = appDelegate.midiManager.noteSettings;
	NoteSetting *setting;
	
	switch ([indexPath indexAtPosition: 0]) {
		case(0):
			switch([indexPath indexAtPosition: 1]) {
				case(0): {
					NSString *label = @"";
					int count = 0;
					for (setting in noteSettings) {
						if (setting.isOn) {
							if (count == 0) {
								label = setting.label;
							} else {
								label = [NSString stringWithFormat:@"%@  %@",label, setting.label];
							}
							count++;
						}
					}
					cell.textLabel.text = label;
					cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				}
			break;
		}
		break;
		case(1): {
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			UISwitch *resetControl = [[UISwitch alloc] initWithFrame: CGRectMake(265, 10, 0, 0) ];
			switch([indexPath indexAtPosition: 1]) {
				case(0):
					cell.textLabel.text = @"Half Note";
					resetControl.on = appDelegate.modeA.circleHalfNote.isOn;
					resetControl.tag = 1;
					break;
				case(1):
					cell.textLabel.text = @"Quarter Note";
					resetControl.on = appDelegate.modeA.circleQuarterNote.isOn;
					resetControl.tag = 2;
					break;
				case(2):
					cell.textLabel.text = @"Eighth Note";
					resetControl.on = appDelegate.modeA.circleEighthNote.isOn;
					resetControl.tag = 3;
					break;
			}
			[resetControl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
			[cell addSubview: resetControl ];
			[resetControl release];
		}
		break;
			case(2): {
				switch([indexPath indexAtPosition: 1]) {
                    case(0):
						cell.textLabel.text = @"120";
						cell.selectionStyle = UITableViewCellSelectionStyleNone;
						bpmLabel = cell.textLabel;
				
						UISlider *bpmControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(58, 0, 300, 50) ];
						bpmControl.minimumValue = 60.0;
						bpmControl.maximumValue = 200.0;
						bpmControl.tag = 0;
						bpmControl.value = 120;
						bpmControl.continuous = YES;
						[bpmControl addTarget:self action:@selector(bpmSliderAction:) forControlEvents:UIControlEventValueChanged];
						[cell addSubview: bpmControl];
						[bpmControl release];
					break;
				}
			}
			break;
			case(3): {
				switch([indexPath indexAtPosition: 1]) {
                    case(0):
						cell.textLabel.text = @"DSMI";
						cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
					break;
				}
			}
			break;
		}
    
    

    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case(0):
            return @"Scale";
		break;
        case(1):
			return @"Notes";
		break;
        case(2):
			return @"BPM";
		break;
		case(3):
			return @"MIDI Out";
		break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 45.0f;
	
}


- (void)switchAction:(UISwitch*)sender
{
	NSLog(@"switchAction: sender = %d, isOn %d",  [sender tag], [sender isOn]);	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.modeA toggleShape:[sender tag] status:[sender isOn]];	
}



- (void)bpmSliderAction:(UISlider*)sender
{
	
	int val = round([sender value]);
	NSLog(@"%i", val);
	bpmLabel.text = [NSString stringWithFormat:@"%i", val];
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.midiManager setBPM:val];	
	
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	switch ([indexPath indexAtPosition: 0]) {
		case(0):
			switch ([indexPath indexAtPosition: 1]) {
				case(0):
					[tableView deselectRowAtIndexPath:indexPath animated:NO];
					NoteSettingsTableViewController *notesController = [[NoteSettingsTableViewController alloc] init];
					notesController.contentSizeForViewInPopover = self.tableView.frame.size;
					//notesController.contentSizeForViewInPopover = CGSizeMake(280, 570);
					[self.navigationController pushViewController:notesController animated:YES];
					[notesController release];
				break;
			}
		break;
		case(3):
			switch ([indexPath indexAtPosition: 1]) {
				case(0):
					[tableView deselectRowAtIndexPath:indexPath animated:NO];
					DSMIDIInfoViewController *dsMidiInfoController = [[DSMIDIInfoViewController alloc] init];
					dsMidiInfoController.contentSizeForViewInPopover = self.tableView.frame.size;
					[self.navigationController pushViewController:dsMidiInfoController animated:YES];
					[dsMidiInfoController release];
					break;
			}
			break;
			
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

