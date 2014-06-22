//
//  AQStringConstants.h
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#define kJBStringLabelXAxis localize(@"label.x.axis", @"x%d")
#define kJBStringLabelYAxis localize(@"label.y.axis", @"y%d")
#define kJBStringLabelChart localize(@"label.chart", @"Chart %d")
#define kJBStringLabelAnscombeQuartet localize(@"label.anscombe.quartet", @"Anscombe’s Quartet")
#define kJBStringLabelChartDetails localize(@"label.chart.details", @"Chart %d Details")
