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

@protocol AQScrollViewDataSource;
@protocol AQScrollViewDelegate;

@interface AQChartScrollView : UIScrollView

@property (nonatomic, weak) id<AQScrollViewDataSource> scrollDataSource;
@property (nonatomic, weak) id<AQScrollViewDelegate> scrollDelegate;

- (void)reloadData;

@end

@protocol AQScrollViewDataSource <NSObject>

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
    
    self.scrollView = [[AQChartScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 200)];
    self.scrollView.scrollDataSource = self;
    self.scrollView.scrollDelegate = self;
    [self.tableView setTableHeaderView:self.scrollView];
}


@end

@implementation AQChartScrollView

- (void)reloadData
{
    
}

@end