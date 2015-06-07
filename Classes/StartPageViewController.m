    //
//  StartPageViewController.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "StartPageViewController.h"
#import "TestInfo.h"
#import "MultiplyViewController.h"
#import "AboutViewController.h"
#import "FlurryAPI.h"

@implementation StartPageViewController
@synthesize testType;
@synthesize numberToTest, roundsToTest;

-(IBAction) startClick {
	TestInfo *info = [[[TestInfo alloc] init] autorelease];
	info.number = [numberToTest selectedSegmentIndex] + 1;
	info.testType = [testType selectedSegmentIndex];
	info.rounds = [roundsToTest selectedSegmentIndex] + 1;
	
	MultiplyViewController *view = [[MultiplyViewController alloc] initWithNibName:nil bundle:nil];
	view.testInfo = info;
    
    
    NSString *eventInfo = [NSString stringWithFormat:@"Launching %d, N:%d, R:%d", info.testType, info.number, info.rounds];
    [FlurryAPI logEvent: eventInfo];
	
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction) aboutClick {
	AboutViewController *view = [[AboutViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}


@end
