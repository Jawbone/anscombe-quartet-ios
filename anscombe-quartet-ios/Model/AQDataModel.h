//
//  QADataModel.h
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <Foundation/Foundation.h>

// Enums
typedef NS_ENUM(NSInteger, AQDataModelChartType){
    AQDataModelChartType1,
	AQDataModelChartType2,
    AQDataModelChartType3,
    AQDataModelChartType4,
    AQDataModelChartTypeCount
};

@interface AQDataPoint : NSObject

- (id)initWithDataPoint:(CGPoint)point;

@property (nonatomic, readonly) CGPoint point;

@end

@interface AQDataModel : NSObject

+ (AQDataModel *)sharedInstance;

- (NSArray *)dataForChartType:(AQDataModelChartType)chartType;

@end
