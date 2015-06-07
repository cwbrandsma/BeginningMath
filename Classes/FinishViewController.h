//
//  FinishViewController.h
//  DyslexicMath
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestInfo.h"
#import <AVFoundation/AVFoundation.h>


@interface FinishViewController : UIViewController {
	TestInfo *testInfo;
	UILabel *paramsLabel;
	AVAudioPlayer* theAudio;
}

@property (nonatomic, retain) TestInfo *testInfo;
@property (nonatomic, retain) IBOutlet UILabel *paramsLabel;
@property (nonatomic, retain) AVAudioPlayer* theAudio;

-(IBAction) click;
@end
