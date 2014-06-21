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
typedef NS_ENUM(NSInteger, AQChartViewChartType){
    AQChartViewChartType1,
	AQChartViewChartType2,
    AQChartViewChartType3,
    AQChartViewChartType4,
    AQChartViewChartTypeCount
};

// Numerics (AQChartLegendView)
CGFloat static const kAQChartLegendViewMarginSize = 15.0f;
CGFloat static const kAQChartLegendViewSeparatorWidth = 0.25f;

// Numerics (AQChartGridView)
CGFloat static const kAQChartGridViewPadding = 5.0f;

@interface AQChartLegendView : UIView

@property (nonatomic, strong) UILabel *yAxisLabel;
@property (nonatomic, strong) UILabel *xAxisLabel;

@end

@interface AQChartView : UIView

@property (nonatomic, strong) JBLineChartView *lineChartView;
@property (nonatomic, strong) AQChartLegendView *chartLegendView;

@end

@interface AQChartGridView : UIView

@property (nonatomic, strong) NSArray *chartViews;

- (void)reloadData;

@end

@interface AQChartViewController () <JBLineChartViewDataSource, JBLineChartViewDelegate>

@property (nonatomic, strong) AQChartGridView *chartGridView;
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.chartGridView = [[AQChartGridView alloc] initWithFrame:self.view.bounds];
    self.view = self.chartGridView;
    
    NSMutableArray *mutableChartGrids = [[NSMutableArray alloc] init];
    for (int chartIndex=0; chartIndex<AQChartViewChartTypeCount; chartIndex++)
    {
        AQChartView *chartView = [[AQChartView alloc] init];
        chartView.lineChartView.delegate = self;
        chartView.lineChartView.dataSource = self;
        chartView.lineChartView.tag = chartIndex;
        chartView.chartLegendView.xAxisLabel.text = [NSString stringWithFormat:@"x%d", chartIndex];
        chartView.chartLegendView.yAxisLabel.text = [NSString stringWithFormat:@"y%d", chartIndex];
        [mutableChartGrids addObject:chartView];
    }
    self.chartGridView.chartViews = [NSArray arrayWithArray:mutableChartGrids];
    
    [self.chartGridView reloadData];
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

@implementation AQChartLegendView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setContentMode:UIViewContentModeRedraw];
        
        _yAxisLabel = [[UILabel alloc] init];
        _yAxisLabel.backgroundColor = [UIColor clearColor];
        _yAxisLabel.textAlignment = NSTextAlignmentCenter;
        _yAxisLabel.textColor = kAQColorLegendTextColor;
        _yAxisLabel.font = [UIFont italicSystemFontOfSize:8.0f];
        [self addSubview:_yAxisLabel];
        
        _xAxisLabel = [[UILabel alloc] init];
        _xAxisLabel.backgroundColor = [UIColor clearColor];
        _xAxisLabel.textAlignment = NSTextAlignmentCenter;
        _xAxisLabel.textColor = kAQColorLegendTextColor;
        _xAxisLabel.font = [UIFont italicSystemFontOfSize:8.0f];
        [self addSubview:_xAxisLabel];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, kAQColorLegendSeparatorColor.CGColor);
    CGContextSetLineWidth(context, kAQChartLegendViewSeparatorWidth);
    CGContextSetShouldAntialias(context, YES);

    CGFloat xOffset = kAQChartLegendViewMarginSize - kAQChartLegendViewSeparatorWidth;
    CGFloat yOffset = self.bounds.origin.y;
    
    CGContextSaveGState(context);
    {
        CGContextMoveToPoint(context, xOffset, yOffset);
        yOffset = self.bounds.size.height - kAQChartLegendViewMarginSize + kAQChartLegendViewSeparatorWidth;
        CGContextAddLineToPoint(context, xOffset, yOffset);
        xOffset = CGRectGetMaxX(self.bounds);
        CGContextAddLineToPoint(context, xOffset, yOffset);
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize yAxisLabelSize = [self.yAxisLabel.text sizeWithAttributes:@{NSFontAttributeName:self.yAxisLabel.font}];
    self.yAxisLabel.frame = CGRectMake(self.bounds.origin.x, ceil((self.bounds.size.height - kAQChartLegendViewMarginSize) * 0.5) - ceil(yAxisLabelSize.height * 0.5), yAxisLabelSize.width, yAxisLabelSize.height);
    
    CGSize xAxisLabelSize = [self.xAxisLabel.text sizeWithAttributes:@{NSFontAttributeName:self.yAxisLabel.font}];
    self.xAxisLabel.frame = CGRectMake(ceil((self.bounds.size.width + kAQChartLegendViewMarginSize) * 0.5) - ceil(xAxisLabelSize.width * 0.5), self.bounds.size.height - kAQChartLegendViewMarginSize, xAxisLabelSize.width, xAxisLabelSize.height);
}

@end

@implementation AQChartView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _chartLegendView = [[AQChartLegendView alloc] init];
        _chartLegendView.backgroundColor = [UIColor clearColor];
        [self addSubview:_chartLegendView];
        
        _lineChartView = [[JBLineChartView alloc] init];
        _lineChartView.backgroundColor = kAQColorBaseBackgroundColor;
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.chartLegendView.frame = self.bounds;
    self.lineChartView.frame = CGRectMake(kAQChartLegendViewMarginSize, self.bounds.origin.y, self.bounds.size.width - kAQChartLegendViewMarginSize, self.bounds.size.height - kAQChartLegendViewMarginSize);
}

@end

@implementation AQChartGridView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kAQColorBaseBackgroundColor;
    }
    return self;
}

#pragma mark - Data

- (void)reloadData
{
    for (AQChartView *chartView in self.chartViews)
    {
        if ([chartView isKindOfClass:[AQChartView class]])
        {
            [chartView.lineChartView reloadData];
        }
    }
    
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.chartViews count] > 0)
    {
        // Layout assumes max 4 charts
        NSAssert([self.chartViews count] == 4, @"AQChartGridView // layout supports exactly 4 charts.");
        
        CGFloat chartWidth = ceil((self.bounds.size.width - (kAQChartGridViewPadding * 3)) * 0.5f);
        CGFloat chartHeight = ceil((self.bounds.size.height - (kAQChartGridViewPadding * 3)) * 0.5f);
        
        CGFloat xOffset = kAQChartGridViewPadding;
        CGFloat yOffset = kAQChartGridViewPadding;
        
        for (AQChartView *chartView in self.chartViews)
        {
            chartView.frame = CGRectMake(xOffset, yOffset, chartWidth, chartHeight);
            
            if (chartView.lineChartView.tag == AQChartViewChartType2)
            {
                yOffset += chartHeight + kAQChartGridViewPadding;
                xOffset = kAQChartGridViewPadding;
            }
            else
            {
                xOffset += chartWidth + kAQChartGridViewPadding;
            }
        }
    }
}

#pragma mark - Setters

- (void)setChartViews:(NSArray *)chartViews
{
    for (AQChartView *oldChartView in self.chartViews)
    {
        [oldChartView removeFromSuperview];
    }
    
    for (AQChartView *newChartView in chartViews)
    {
        [self addSubview:newChartView];
    }
    
    _chartViews = chartViews;
    
    [self setNeedsLayout];
}

@end
