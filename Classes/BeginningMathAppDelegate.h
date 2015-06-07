//
//  BeginningMathAppDelegate.h
//  BeginningMath
//
//  Created by Chris Brandsma on 8/11/10.
//  Copyright DiamondB Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeginningMathAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@end

