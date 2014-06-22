//
//  QADataModel.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AQDataModel.h"

@interface AQDataModel ()

@property (nonatomic, strong) NSArray *chartData1;
@property (nonatomic, strong) NSArray *chartData2;
@property (nonatomic, strong) NSArray *chartData3;
@property (nonatomic, strong) NSArray *chartData4;

@end

@interface AQDataPoint ()

@property (nonatomic, assign) CGPoint point;

@end

@implementation AQDataModel

#pragma mark - Alloc/Init

+ (AQDataModel *)sharedInstance
{
    static dispatch_once_t pred;
    static AQDataModel *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
	return instance;
}

#pragma mark - Getters

- (NSArray *)dataForChartType:(AQDataModelChartType)chartType
{
    switch (chartType) {
        case AQDataModelChartType1:
            return self.chartData1;
            break;
        case AQDataModelChartType2:
            return self.chartData2;
            break;
        case AQDataModelChartType3:
            return self.chartData3;
            break;
        case AQDataModelChartType4:
            return self.chartData4;
            break;
        default:
            break;
    }
    return nil;
}

- (NSArray *)chartData1
{
    if (_chartData1 == nil)
    {
       _chartData1 = @[[[AQDataPoint alloc] initWithDataPoint:CGPointMake(10.0f, 8.04f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 6.95f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(13.0f, 7.58f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(9.0f, 8.81f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(11.0f, 8.33f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(14.0f, 9.96f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 7.24f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 4.26f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(12.0f, 10.84f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 4.82f)],
                       [[AQDataPoint alloc] initWithDataPoint:CGPointMake(5.0f, 5.68f)],
                       ];
        
        _chartData1 = [_chartData1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            AQDataPoint *dataPoint1 = (AQDataPoint *)obj1;
            AQDataPoint *dataPoint2 = (AQDataPoint *)obj2;
            if (dataPoint1.point.x > dataPoint2.point.x)
            {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
    }
    return _chartData1;
}

- (NSArray *)chartData2
{
    if (_chartData2 == nil)
    {
        _chartData2 = @[[[AQDataPoint alloc] initWithDataPoint:CGPointMake(10.0f, 9.14f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 8.14f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(13.0f, 8.74f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(9.0f, 8.77f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(11.0f, 9.26f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(14.0f, 8.10f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 6.13f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 3.10f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(12.0f, 9.13f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 7.26f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(10.0f, 9.14f)],
                        ];
        
        _chartData2 = [_chartData2 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            AQDataPoint *dataPoint1 = (AQDataPoint *)obj1;
            AQDataPoint *dataPoint2 = (AQDataPoint *)obj2;
            if (dataPoint1.point.x > dataPoint2.point.x)
            {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
    }
    return _chartData2;
}

- (NSArray *)chartData3
{
    if (_chartData3 == nil)
    {
        _chartData3 = @[[[AQDataPoint alloc] initWithDataPoint:CGPointMake(10.0f, 7.46f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 6.77f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(13.0f, 12.74f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(9.0f, 7.11f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(11.0f, 7.81f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(14.0f, 8.84f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 6.08f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 5.39f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(12.0f, 8.15f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 6.42f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(10.0f, 7.46f)],
                        ];
        
        _chartData3 = [_chartData3 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            AQDataPoint *dataPoint1 = (AQDataPoint *)obj1;
            AQDataPoint *dataPoint2 = (AQDataPoint *)obj2;
            if (dataPoint1.point.x > dataPoint2.point.x)
            {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
    }
    return _chartData3;
}

- (NSArray *)chartData4
{
    if (_chartData4 == nil)
    {
        _chartData4 = @[[[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 6.58f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 5.76f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 7.71f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 8.84f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 8.47f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 7.04f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 5.25f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(19.0f, 12.50f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 5.56f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 7.91f)],
                        [[AQDataPoint alloc] initWithDataPoint:CGPointMake(8.0f, 6.58f)],
                        ];
        
        _chartData4 = [_chartData4 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            AQDataPoint *dataPoint1 = (AQDataPoint *)obj1;
            AQDataPoint *dataPoint2 = (AQDataPoint *)obj2;
            if (dataPoint1.point.x > dataPoint2.point.x)
            {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
    }
    return _chartData4;
}

@end

@implementation AQDataPoint

#pragma mark - Alloc/Init

- (id)initWithDataPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        _point = point;
    }
    return self;
}

@end
