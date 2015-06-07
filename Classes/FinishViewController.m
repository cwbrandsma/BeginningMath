    //
//  FinishViewController.m
//  DyslexicMath
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "FinishViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TestInfo.h"

@implementation FinishViewController
@synthesize testInfo;
@synthesize paramsLabel;
@synthesize theAudio;

-(NSString *) parseMode {
    switch (self.testInfo.testType) {
        case 0: return @"Learn";
        case 1: return @"Practice";
        case 2: return @"Test";
        case 3: return @"Missing";
            
    }
    return @"";
}

-(NSString *) parseTime {
	NSDate *stop = [NSDate date];
	NSTimeInterval interval = [stop timeIntervalSinceDate:self.testInfo.start];
	
    int seconds = interval;
    int minutes = interval / 60;
    if (minutes > 0) {
        seconds = seconds - (minutes * 60);
        if (seconds < 10)
            return 	[NSString stringWithFormat: @"%d:0%d minutes", minutes, seconds];
        else
            return 	[NSString stringWithFormat: @"%d:%d minutes", minutes, seconds];
    } else {
        return 	[NSString stringWithFormat: @"%d seconds", seconds];        
    }
}


-(void) loadParamsLabel {
//	NSDate *stop = [NSDate date];
//	NSTimeInterval interval = [stop timeIntervalSinceDate:self.testInfo.start];
	NSString *seconds = [self parseTime]; //[NSString stringWithFormat: @"%d", (int)interval];
	NSString *testMode =[self parseMode];
	NSString *rounds = self.testInfo.rounds == 1?@"round":@"rounds";
	NSString *msg = [NSString stringWithFormat: @"You completed %d %@ for number %d in %@ mode in %@", 
					 self.testInfo.rounds,
					 rounds,
					 self.testInfo.number,
					 testMode,
					 seconds];
	paramsLabel.text = msg;
	
}

-(void) playSound: (NSString*) value {
	NSString * path = [[NSBundle mainBundle] pathForResource: value ofType: @"wav"];
	self.theAudio = [[[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil] autorelease];
	[theAudio prepareToPlay];
	[theAudio play];	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self loadParamsLabel];
	[self playSound:@"yay"];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[theAudio release];
	[testInfo release];
    [super dealloc];
}

-(IBAction) click {
	//[self.view removeFromSuperview];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
