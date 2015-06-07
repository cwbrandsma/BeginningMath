//
//  MultiplyViewController.h
//  DyslexicMath
//
//  Created by Chris Brandsma on 6/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestInfo.h"
#import <AVFoundation/AVFoundation.h>

@interface MultiplyViewController : UIViewController {
	TestInfo *testInfo;
	NSArray *testValues;
	int testIndex;
	
	UILabel *value1;
	UILabel *value2;
	UILabel *answer;
	UILabel *correctCount;
	UIImageView *answerImage;
	
	UIView *starsView;
	
	UIView *value1View;
	UIView *value2View;
    UIView *answerView;
	
	AVAudioPlayer* theAudio;
	AVAudioPlayer* answerAudio;
}

@property (nonatomic, retain) IBOutlet UILabel *value1;
@property (nonatomic, retain) IBOutlet UILabel *value2;
@property (nonatomic, retain) IBOutlet UILabel *answer;
@property (nonatomic, retain) IBOutlet UILabel *correctCount;
@property (nonatomic, retain) IBOutlet UIImageView *answerImage;
@property (nonatomic, retain) IBOutlet UIView *value1View;
@property (nonatomic, retain) IBOutlet UIView *value2View;
@property (nonatomic, retain) IBOutlet UIView *answerView;
@property (nonatomic, retain) IBOutlet UIView *starsView;


@property (nonatomic,retain) TestInfo *testInfo;
@property (nonatomic, retain) NSArray *testValues;

@property (nonatomic, retain) AVAudioPlayer* theAudio;
@property (nonatomic, retain) AVAudioPlayer* answerAudio;


-(IBAction) numberClick: (id) sender;
-(IBAction) enterClick;
-(IBAction) returnClick;

@end
