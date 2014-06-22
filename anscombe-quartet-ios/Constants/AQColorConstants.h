//
//  AQColorConstants.h
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#pragma mark - Base

#define kAQColorBaseBackgroundColor UIColorFromHex(0xf5f4f0)
#define kAQColorLegendSeparatorColor UIColorFromHex(0x585858)
#define kAQColorLegendTextColor UIColorFromHex(0x585858)
#define kAQColorChartTitleColor UIColorFromHex(0x000000)
#define kQAColorChartDotColor UIColorFromHex(0xe23100)
