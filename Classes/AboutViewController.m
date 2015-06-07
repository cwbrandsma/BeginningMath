//
//  AboutViewController.m
//  BeginningMath
//
//  Created by Chris Brandsma on 1/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>

@implementation AboutViewController

-(IBAction) returnClick {
	[self.navigationController popViewControllerAnimated:YES];	
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction) contactSupportClick: (id) sender{
	MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
	mc.mailComposeDelegate = self;
	[mc setToRecipients:[NSArray arrayWithObject:@"support@diamondbsoftware.com"]];
	[mc setSubject:@"Beginning Math"];
	
	[self presentModalViewController:mc animated:YES];
	[mc release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	/* Notifies users about errors associated with the interface
	 switch (result)
	 {
	 case MFMailComposeResultCancelled:
	 break;
	 case MFMailComposeResultSaved:
	 break;
	 case MFMailComposeResultSent:
	 break;
	 case MFMailComposeResultFailed:
	 break;
	 
	 default:
	 {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 [alert show];
	 [alert release];
	 }
	 
	 break;
	 }*/
	[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)gotoReviews:(id)sender {
	NSString *iTunesLink = @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=395247000&mt=8";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];	
}

-(IBAction) webClick {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://DiamondBSoftware.com"]];
}

-(IBAction) timeTableAppClick{
	// 392502758 times table helper app id
	NSString *iTunesLink = @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=392502758&mt=8";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];	
	
}


@end
