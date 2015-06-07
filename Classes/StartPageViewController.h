//
//  StartPageViewController.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartPageViewController : UIViewController {
	UISegmentedControl *testType;
	UISegmentedControl *numberToTest;
	UISegmentedControl *roundsToTest;
}
@property (nonatomic, retain) IBOutlet UISegmentedControl *testType;
@property (nonatomic, retain) IBOutlet UISegmentedControl *numberToTest;
@property (nonatomic, retain) IBOutlet UISegmentedControl *roundsToTest;



-(IBAction) startClick;
-(IBAction) aboutClick;

@end
