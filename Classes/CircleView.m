//
//  CircleView.m
//  BeginningMath
//
//  Created by Chris Brandsma on 9/5/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
	// Get the graphics context and clear it
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextClearRect(ctx, rect);
	
	// Draw a green solid circle
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	CGContextFillEllipseInRect(ctx, rect);	
}


@end
