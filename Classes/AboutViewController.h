//
//  AboutViewController.h
//  BeginningMath
//
//  Created by Chris Brandsma on 1/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController<MFMailComposeViewControllerDelegate> {

}


-(IBAction) contactSupportClick: (id) sender;
-(IBAction) returnClick;
-(IBAction) gotoReviews:(id)sender;
-(IBAction) webClick;
-(IBAction) timeTableAppClick;

@end
