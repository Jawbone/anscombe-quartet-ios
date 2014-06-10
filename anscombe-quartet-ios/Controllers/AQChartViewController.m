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

@end

@interface AQChartViewController () <AQScrollViewDataSource, AQScrollViewDelegate>

@property (nonatomic, strong) AQChartScrollView *scrollView;
@property (nonatomic, strong) NSArray *chartViews;

@end

@implementation AQChartViewController

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.scrollView = [[AQChartScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kAQChartScrollViewHeight)];
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;
    [self.scrollView reloadData];
    [self.tableView setTableHeaderView:self.scrollView];
}

#pragma mark - AQScrollViewDataSource

- (NSUInteger)numberOfChartsInChartScrollView:(AQChartScrollView *)chartScrollView
{
    return 4;
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