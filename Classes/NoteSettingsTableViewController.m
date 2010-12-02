//
//  NoteSettingsTableViewController.m
//  AmosUIView
//
//  Created by Justin Rhoades on 11/3/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "NoteSettingsTableViewController.h"
#import "AmosAppDelegate.h"
#import "AmosMIDIManager.h"
#import "NoteSetting.h"
#import "ModeAViewController.h"


@implementation NoteSettingsTableViewController


@synthesize noteSettings;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    self = [ super initWithStyle: UITableViewStylePlain ];
    if (self) {
        self.title = @"Notes";
		AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		noteSettings = delegate.midiManager.noteSettings;
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [noteSettings count];

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];		
    
	
	// Configure the cell...
	int isOnNoteCount = 0;
	for (NoteSetting *s in noteSettings) {
		if(s.isOn) {
			isOnNoteCount++;
		}
	}
	
	
	NoteSetting *setting = [noteSettings objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@", setting.label];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UISwitch *control = [[UISwitch alloc] initWithFrame: CGRectMake(265, 10, 0, 0) ];
	control.on = setting.isOn;
	
	if (setting.isOn) {
		cell.textLabel.textColor = [UIColor blackColor];
		if (isOnNoteCount == 1) {
			control.enabled = false;
		}
	} else {
		cell.textLabel.textColor = [UIColor lightGrayColor];		
	}
	
	//cell.frame.origin.x = 40;
	
	control.tag = indexPath.row;
	[control addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
	[cell addSubview: control ];
	[control release];
	
	/*
	cell.textLabel.textColor = [UIColor lightGrayColor];
	cell.textLabel.highlightedTextColor = [UIColor whiteColor];		
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	AmosAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	if (appDelegate.midiManager.noteSetting == indexPath.row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		cell.textLabel.textColor = [UIColor blackColor];		
	}
	 */

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 1;
} 





- (void)switchAction:(UISwitch*)sender
{
	NSLog(@"switchAction: sender = %d, isOn %d",  [sender tag], [sender isOn]);
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
	UITableViewCell *cell =  [self.tableView cellForRowAtIndexPath:indexPath];

	if ([sender isOn]) {
		cell.textLabel.textColor = [UIColor blackColor];	
		NSLog(@"ON");
	} else {
		cell.textLabel.textColor = [UIColor lightGrayColor];		
		NSLog(@"OFF");		
	}
	
	
	NoteSetting *setting = [noteSettings objectAtIndex:[sender tag]];
	setting.isOn = [sender isOn];
	
	AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.modeA noteSettingsDidChange];
	
	[self.tableView reloadData];
	
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


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


- (void)dealloc {
    [super dealloc];
}


@end

