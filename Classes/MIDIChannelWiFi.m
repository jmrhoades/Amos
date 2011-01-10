//
//  MIDIChannelWiFi.m
//  Amos
//
//  Created by Justin Rhoades on 12/8/10.
//  Copyright 2010 Anything Honest. All rights reserved.
//

#import "MIDIChannelWiFi.h"
#import "AmosAppDelegate.h"
#import "AmosMIDIManager.h"
#import "DSMIDIInfoViewController.h"

@implementation MIDIChannelWiFi


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
       self.title = @"DSMI MIDI Channel";
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

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
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case(0): {
            return 16;
		}
		break;
        case(1): {
			return 1;
		}
		break;
	}
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case(0):
            return @"MIDI Channel";
			break;
        case(1):
			return @"Help";
			break;
	}
    return nil;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    //}

	// Force configure each cell...
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];


	switch ([indexPath indexAtPosition: 0]) {
		case(0): {
			
			cell.textLabel.text = [NSString stringWithFormat:@"Channel %i", indexPath.row + 1 ];

			AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			if (indexPath.row == delegate.midiManager.midiChannelWiFi) {
				cell.textLabel.textColor = [UIColor colorWithRed:1.0*50/256 green:1.0*79/256 blue:1.0*133/256 alpha:1];	
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			} else {
				cell.textLabel.textColor = [UIColor lightGrayColor];
			}
			
			
		}
			break;
		case(1): {
			
			cell.textLabel.text =  @"DSMI Setup Instructions";			
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		}
			break;
	}
	
	
	
	

    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	switch ([indexPath indexAtPosition: 0]) {
		case(0): {
			return 32.0f;
		}
		break;
		case(1): {
			return 42.0f;
		}
	}
	return 42.0f;
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
		case(0): {
			
			[tableView deselectRowAtIndexPath:indexPath animated:NO];
			
			AmosAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			delegate.midiManager.midiChannelWiFi = indexPath.row;

			[self.tableView reloadData];
			
			//[[self navigationController] popViewControllerAnimated:YES];
			
		}
			break;
		case(1): {
			
			
			 DSMIDIInfoViewController *dsMidiInfoController = [[DSMIDIInfoViewController alloc] init];
			 dsMidiInfoController.contentSizeForViewInPopover = self.tableView.frame.size;
			 [self.navigationController pushViewController:dsMidiInfoController animated:YES];
			 [dsMidiInfoController release];
			
			
			
			
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


- (void)dealloc {
    [super dealloc];
}


@end

