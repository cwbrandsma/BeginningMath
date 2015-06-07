//
//  TestInfo.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TestInfo : NSObject {
	int testType;
	int number;
	int rounds;
	NSDate *start;
	NSDate *stop;
}

@property int testType;
@property int number;
@property int rounds;
@property (nonatomic, retain) NSDate *start;
@property (nonatomic, retain) NSDate *stop;

-(NSArray *) setupTest;

@end
