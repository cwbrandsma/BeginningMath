    //
//  MultiplyViewController.m
//  DyslexicMath
//
//  Created by Chris Brandsma on 6/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "MultiplyViewController.h"
#import "TestValues.h"
#import "FinishViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CircleView.h"
#import <QuartzCore/QuartzCore.h>

#define kTypeLearn 0
#define kTypePractice 1
#define kTypeTest 2
#define kTestMissing 3

@implementation MultiplyViewController
@synthesize testInfo, testValues;
@synthesize value1, value2, answer;
@synthesize correctCount;
@synthesize theAudio, answerAudio;
@synthesize answerImage;
@synthesize value1View, value2View, answerView;
@synthesize starsView;


#pragma mark -
#pragma mark Image Methods
- (void)removeImage:(UIImageView *)imageView {
	[UIView beginAnimations:@"removeImage" context:nil];
	imageView.alpha = 0.0;
	[UIView commitAnimations];
}

-(void) flashImage: (NSString *) imageNamed {
	answerImage.image = [UIImage imageNamed:imageNamed];
	answerImage.alpha = 1.0;
	answerImage.hidden = NO;
	
	[self performSelector:@selector(removeImage:)
			   withObject:answerImage
			   afterDelay:1];
}

#pragma mark -
#pragma mark Sound Methods
-(void) playSound: (NSString*) value {
	NSString * path = [[NSBundle mainBundle] pathForResource: value ofType: @"wav"];
	self.theAudio = [[[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil] autorelease];
	[theAudio prepareToPlay];
	[theAudio play];	
}

-(void) vocalizeFile: (NSString *) value {
	NSString * path = [[NSBundle mainBundle] pathForResource: value ofType: @"mp3"];
	self.answerAudio = [[[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil] autorelease];
	[answerAudio prepareToPlay];
	[answerAudio play];	
}

-(void) vocalizeNumberAndAnswer: (TestValues *) values {
	NSString *sound = [NSString stringWithFormat:@"%d+%d=%d", values.value1, values.value2, values.answer];;
	[self vocalizeFile: sound];
}
-(void) vocalizeNumber: (TestValues *) values {
	NSString *sound = [NSString stringWithFormat:@"%d+%d", values.value1, values.value2];;
	[self vocalizeFile: sound];	
}
#pragma mark -

-(void) visualizeCount {
	// clear out the view
	for (UIControl *ctrl in [starsView subviews]) {
		[ctrl removeFromSuperview];
	}
	const int starH = 64;
	const int starW = 64;
	int mycorrectCount = [correctCount.text intValue];
	
	int i = 0;
	for (int round = 0; round < testInfo.rounds; round++) {
		for (int x = 0; x < 9; x++) {
			NSString *starName = (mycorrectCount-1 >= i)?@"star64.png":@"whitestar64.png";
			UIImage *image = [UIImage imageNamed:starName];
			UIImageView *iview = [[UIImageView alloc] initWithImage:image];
			
			CGFloat posX = x * (starW + 5);
			CGFloat posY = round * (starH + 5);
			iview.frame = CGRectMake(posX, posY, starW, starH);
		
			[starsView addSubview:iview];
			[iview release];

			i++;
		}
	}
}

-(void) visualizeNumber: (UIView *) aView: (int) number {
	// clear out the view
	for (UIControl *ctrl in [aView subviews]) {
		[ctrl removeFromSuperview];
	}
	
	const int gemSize = 40;
	const int gemSpace = 4;
	//int y1 = 34;
	//int y2 = 0;
	//int x = aView.frame.size.width-gemSize;
    int rightPos = aView.frame.size.width-gemSize;  //entire with, minus one gem so the first gem fits
    
    //NOTE: there is room for 5 star in a line
	
	for (int i=0; i<number; i++) {
        int col = i / 5;
        int row = i % 5;
        
        int y = 34 * col;
        
        int slot = row * (gemSize - gemSpace);
        int x = rightPos - slot;
        
		UIImage *image = [UIImage imageNamed:@"Apple.png"];
		UIImageView *gem = [[UIImageView alloc] initWithImage:image];
        
        gem.frame = CGRectMake(x, y, gemSize, gemSize);

		[aView addSubview:gem];
		[gem release];
	}
}

-(void) testComplete {
	FinishViewController *view = [[FinishViewController alloc] initWithNibName:nil bundle:nil];
	view.testInfo = testInfo;
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}

#pragma mark -
#pragma mark Standard number test


// Standard test type setup.  You get both problem numbers and fill in the answer
-(void) setupStandardTest: (TestValues *) test {
	self.value1.text = [NSString stringWithFormat:@"%d", test.value1];
	self.value2.text = [NSString stringWithFormat:@"%d", test.value2];
	self.answer.text = @"";	
    
    [self visualizeNumber:self.value1View :test.value1];
    [self visualizeNumber:self.value2View :test.value2];        
}

#pragma mark -
#pragma mark Missing number test
// Missing number tet type setup.
// You get one problem and the answer, you fill in the missing problem.
// Like subtraction...just not.
-(void) setupMissingNumberTest:(TestValues*) test {
	self.value1.text = [NSString stringWithFormat:@"%d", test.value1];
	self.value2.text = @""; // [NSString stringWithFormat:@"%d", test.value2];
	self.answer.text = [NSString stringWithFormat:@"%d", test.answer];
    
    [self visualizeNumber:self.value1View :test.value1];
    [self visualizeNumber:self.answerView :test.answer];    
}

#pragma mark -
#pragma mark Common Methods

-(UILabel *) getAnswerLabel {
    if (self.testInfo.testType == kTestMissing) {
        return self.value2;
    }else {
        return self.answer;
    }

}

-(void) highlightAnswerLabel {
    UILabel *label = [self getAnswerLabel];
    
    CALayer *hlayer = [[CALayer alloc] init];
    [hlayer setFrame:CGRectMake(0, 0, label.frame.size.width, label.frame.size.height)];
    
    hlayer.cornerRadius = 5;
    hlayer.borderColor = [[UIColor blackColor] CGColor];
    hlayer.borderWidth = 1;
    hlayer.backgroundColor =[[UIColor whiteColor] CGColor];
    hlayer.opacity = 0.2;
    
    [label.layer insertSublayer:hlayer atIndex:[label.layer.sublayers count]]; 
    [hlayer release];

}

-(void) loadTest {
    
	if (testIndex >= [self.testValues count]) {
		[self testComplete];
		return;
	}
	correctCount.text = [NSString stringWithFormat:@"%d", testIndex];
    
	TestValues *test = [self.testValues objectAtIndex:testIndex];
	
    if (self.testInfo.testType == kTestMissing) {
        [self setupMissingNumberTest: test];
    } else {
        [self setupStandardTest:test];
	} 
    
    // say the question
    if (self.testInfo.testType == kTypeLearn) {
		[self vocalizeNumberAndAnswer: test];
	}
	[self visualizeCount];
}

-(BOOL) isAnswerCorrect {
	TestValues *test = [self.testValues objectAtIndex:testIndex];
    if (self.testInfo.testType == kTestMissing) {
        int currentAnswer = [self.value2.text intValue];	
        return test.value2 == currentAnswer;
    } else {
        int currentAnswer = [self.answer.text intValue];	
        return test.answer == currentAnswer;
    }
}

-(void) appendToAnswer: (int) value {
    if (self.testInfo.testType == kTestMissing) {
        NSString *answerText = [NSString stringWithFormat:@"%@%d", self.value2.text, value]; 
        self.value2.text = answerText;
    }else {
        NSString *answerText = [NSString stringWithFormat:@"%@%d", self.answer.text, value]; 
        self.answer.text = answerText;
    }
}
-(void) clearAnswer {
    if (self.testInfo.testType == kTestMissing) {
        self.value2.text = @"";
    } else {
        self.answer.text = @"";
    }
}
-(void) checkAnswer {
    UILabel *currentLabel = [self getAnswerLabel];

    if ([currentLabel.text length] > 3){
        currentLabel.text = @"";
        [self playSound:@"blip"];	
    }
}

-(void) validateAnswer {
    if ([self isAnswerCorrect]) {
		testIndex++;
		[self playSound:@"bell"];
		[self flashImage:@"star.png"];
		[self loadTest];
	} else {
        [self clearAnswer];
		[self flashImage:@"wrong.png"];
		[self playSound:@"blip"];
	}
}

#pragma mark -
#pragma mark Gestures
-(IBAction) clear{
    [self clearAnswer];
}	

-(void)clearSwipe:(UIGestureRecognizer *)recognizer {
	[self clearAnswer];
}

-(void) setupGestures {
	UISwipeGestureRecognizer *swipeNext = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clearSwipe:)];
	if ([swipeNext respondsToSelector:@selector(setDirection:)]){
		[swipeNext setDirection:UISwipeGestureRecognizerDirectionLeft];
		[self.view addGestureRecognizer:swipeNext];
	}
	[swipeNext release];
	
	UISwipeGestureRecognizer *swipePrev = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clearSwipe:)];
	if ([swipePrev respondsToSelector:@selector(setDirection:)]){
		[swipePrev setDirection:UISwipeGestureRecognizerDirectionRight];
		[self.view addGestureRecognizer:swipePrev];
	}
	[swipePrev release];
}
#pragma mark -
#pragma mark Memory Management


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	answerImage.hidden = YES;
	testIndex = 0;
	self.testValues = [self.testInfo setupTest];
	self.testInfo.start = [NSDate date];
	
    [self highlightAnswerLabel];
	[self setupGestures];
	[self loadTest];
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
    self.answerView = nil;
	self.value1View = nil;
	self.value2View = nil;
	self.starsView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[theAudio release];
	[answerAudio release];
	[testInfo release];
	[testValues release];
	[value1 release];
	[value2 release];
	[answer release];
	
	[value1View release];
	[value2View release];
    [answerView release];
	[starsView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Click Handlers

-(IBAction) numberClick: (id) sender {
	UIButton *btn = (UIButton*)sender;
	int newValue = btn.tag;
	
    [self appendToAnswer:newValue];
    [self checkAnswer];
    
}


-(IBAction) enterClick {
    [self validateAnswer];
}

-(IBAction) returnClick {
	[self.navigationController popViewControllerAnimated:YES];	
}

@end
