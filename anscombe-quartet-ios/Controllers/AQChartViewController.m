//
//  AQChartViewController.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/9/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AQChartViewController.h"

// Views
#import <JBLineChartView.h>

// Enums
typedef NS_ENUM(NSInteger, AQChartScrollViewChartType){
    AQChartScrollViewChartType1,
	AQChartScrollViewChartType2,
    AQChartScrollViewChartType3,
    AQChartScrollViewChartType4,
    AQChartScrollViewChartTypeCount
};

// Numerics
static const CGFloat kAQChartScrollViewHeight = 200.0f;
static const CGFloat kAQChartScrollViewPageControlHeight = 44.0f;

@protocol AQScrollViewDataSource;
@protocol AQScrollViewDelegate;

@interface AQChartScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) id<AQScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<AQScrollViewDelegate> delegate;

- (void)reloadData;

@end

@protocol AQScrollViewDataSource <NSObject>

- (NSUInteger)numberOfChartsInChartScrollView:(AQChartScrollView *)chartScrollView;

@end

@protocol AQScrollViewDelegate <NSObject>

- (UIView *)chartScrollView:(AQChartScrollView *)chartScrollView chartViewAtIndex:(NSUInteger)index;

@end

@interface AQChartViewController () <AQScrollViewDataSource, AQScrollViewDelegate, JBLineChartViewDataSource, JBLineChartViewDelegate>

@property (nonatomic, strong) AQChartScrollView *scrollView;
@property (nonatomic, strong) NSArray *chartViews;
@property (nonatomic, strong) NSDictionary *dataModel;

- (void)initDataModel;

@end

@implementation AQChartViewController

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initDataModel];
    }
    return self;
}

#pragma mark - Data

- (void)initDataModel
{
    NSMutableDictionary *mutableDataModel = [NSMutableDictionary dictionary];
    self.dataModel = [NSMutableDictionary dictionaryWithDictionary:mutableDataModel];
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    NSMutableArray *mutableChartViews = [[NSMutableArray alloc] init];
    for (int index=0; index < AQChartScrollViewChartTypeCount; index++)
    {
        JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
        lineChartView.tag = index;
        lineChartView.delegate = self;
        lineChartView.dataSource = self;
        [mutableChartViews addObject:lineChartView];
    }
    self.chartViews = [NSArray arrayWithArray:mutableChartViews];
    
    self.scrollView = [[AQChartScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kAQChartScrollViewHeight)];
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;
    [self.scrollView reloadData];
    [self.tableView setTableHeaderView:self.scrollView];
}

#pragma mark - AQScrollViewDataSource

- (NSUInteger)numberOfChartsInChartScrollView:(AQChartScrollView *)chartScrollView
{
    return AQChartScrollViewChartTypeCount;
}

- (UIView *)chartScrollView:(AQChartScrollView *)chartScrollView chartViewAtIndex:(NSUInteger)index
{
    return nil;
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return 0;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return 0;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return 0;
}

@end

@implementation AQChartScrollView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height - kAQChartScrollViewPageControlHeight, self.bounds.size.width, kAQChartScrollViewPageControlHeight)];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)reloadData
{
    
}

@end
