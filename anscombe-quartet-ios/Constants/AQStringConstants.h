//
//  AQStringConstants.h
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#define kAQStringLabelXAxis localize(@"label.x.axis", @"x%d")
#define kAQStringLabelYAxis localize(@"label.y.axis", @"y%d")
#define kAQStringLabelChart localize(@"label.chart", @"Chart %d")
#define kAQStringLabelAnscombeQuartet localize(@"label.anscombe.quartet", @"Anscombe’s Quartet")
#define kAQStringLabelChartDetails localize(@"label.chart.details", @"Chart %d Details")
#define kAQStringLabelClose localize(@"label.close", @"Close")
#define kAQStringLabelX localize(@"label.x", @"X%d")
#define kAQStringLabelY localize(@"label.y", @"Y%d")
