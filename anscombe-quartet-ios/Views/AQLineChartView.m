//
//  AQLineChartView.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AQLineChartView.h"

@implementation AQLineChartView

#pragma mark - Data

- (void)reloadData
{
    [super reloadData];
    
    /*
     * This is a "hack" for the third chart type. 
     * Because JBLineChartView only supports homogenous x-axis distribution, 
     * we can't correctly visualize the vertical distribution of the final chart. 
     * Here, we align every value except the last to the the x-value position.
     * Future versions of the library will be able support this feature -- it's on it's way! 
     */
    if (self.chartIndex == 3)
    {
        for (UIView *chartSubView in self.subviews)
        {
            if ([NSStringFromClass([chartSubView class]) isEqualToString:@"JBLineChartDotsView"])
            {
                NSUInteger dotIndex = 0;
                for (UIView *dotView in chartSubView.subviews)
                {
                    if ([NSStringFromClass([dotView class]) isEqualToString:@"JBLineChartDotView"] && dotIndex != ([chartSubView.subviews count] - 1))
                    {
                        dotView.center = CGPointMake(ceil(self.bounds.size.width * 0.2f), dotView.center.y);
                    }
                    dotIndex++;
                }
            }
        }
    }
}

@end
