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

// Controllers
#import "AQChartDetailViewController.h"
#import "AQBaseNavigationController.h"

// Model
#import "AQDataModel.h"

// Enums (AQCHartViewController)
typedef NS_ENUM(NSInteger, AQCHartViewControllerChartType){
    AQCHartViewControllerChartTypeDot,
	AQCHartViewControllerChartTypeBestFit,
    AQCHartViewControllerChartTypeCount
};

typedef NS_ENUM(NSInteger, AQCHartViewControllerBestFitPoint){
    AQCHartViewControllerBestFitPoint1,
	AQCHartViewControllerBestFitPoint2,
    AQCHartViewControllerBestFitPointCount
};

// Numerics (AQChartLegendView)
CGFloat static const kAQChartLegendViewMarginSize = 15.0f;
CGFloat static const kAQChartLegendViewSeparatorWidth = 0.25f;
CGFloat static const kAQChartLegendViewTitleHeight = 40.0f;

// Numerics (AQChartGridView)
CGFloat static const kAQChartGridViewPadding = 5.0f;

// Numerics (AQCHartViewController)
CGFloat static const kAQCHartViewControllerDotRadius = 4.0f;
CGFloat static const kAQCHartViewControllerLineWidth = 0.5f;

@interface AQLineChartView : JBLineChartView

@property (nonatomic, assign) NSUInteger chartIndex;

@end

@interface AQChartLegendView : UIView

@property (nonatomic, strong) UILabel *yAxisLabel;
@property (nonatomic, strong) UILabel *xAxisLabel;

@end

@protocol AQChartViewDelegate;

@interface AQChartView : UIView

@property (nonatomic, weak) id<AQChartViewDelegate> delegate;
@property (nonatomic, strong) AQLineChartView *dotChartView;
@property (nonatomic, strong) AQLineChartView *bestFitChartView;
@property (nonatomic, strong) AQChartLegendView *chartLegendView;
@property (nonatomic, strong) UILabel *titleLabel;

// Gestures
-  (void)chartViewTapped:(id)sender;

@end

@protocol AQChartViewDelegate <NSObject>

@optional

- (void)didSelectChartView:(AQChartView *)chartView;

@end

@interface AQChartGridView : UIView

@property (nonatomic, strong) NSArray *chartViews;

- (void)reloadData;

@end

@interface AQChartViewController () <JBLineChartViewDataSource, JBLineChartViewDelegate, AQChartViewDelegate>

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
    
    self.title = kJBStringLabelAnscombeQuartet;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.chartGridView = [[AQChartGridView alloc] initWithFrame:self.view.bounds];
    self.view = self.chartGridView;
    
    NSMutableArray *mutableChartGrids = [[NSMutableArray alloc] init];
    for (int chartIndex=0; chartIndex<AQDataModelChartTypeCount; chartIndex++)
    {
        AQChartView *chartView = [[AQChartView alloc] init];
        chartView.delegate = self;
        
        chartView.dotChartView.delegate = self;
        chartView.dotChartView.dataSource = self;
        chartView.dotChartView.tag = AQCHartViewControllerChartTypeDot;
        chartView.dotChartView.userInteractionEnabled = NO;
        chartView.dotChartView.showsLineSelection = NO;
        chartView.dotChartView.showsVerticalSelection = NO;
        ((AQLineChartView *)chartView.dotChartView).chartIndex = chartIndex;
        
        chartView.bestFitChartView.delegate = self;
        chartView.bestFitChartView.dataSource = self;
        chartView.bestFitChartView.tag = AQCHartViewControllerChartTypeBestFit;
        chartView.bestFitChartView.userInteractionEnabled = NO;
        chartView.bestFitChartView.showsLineSelection = NO;
        chartView.bestFitChartView.showsVerticalSelection = NO;
        ((AQLineChartView *)chartView.bestFitChartView).chartIndex = chartIndex;
        
        chartView.tag = chartIndex;

        chartView.chartLegendView.xAxisLabel.text = [NSString stringWithFormat:kJBStringLabelXAxis, chartIndex];
        chartView.chartLegendView.yAxisLabel.text = [NSString stringWithFormat:kJBStringLabelYAxis, chartIndex];
        chartView.titleLabel.text = [NSString stringWithFormat:kJBStringLabelChart, chartIndex + 1];
        [mutableChartGrids addObject:chartView];
    }
    self.chartGridView.chartViews = [NSArray arrayWithArray:mutableChartGrids];
    
    [self.chartGridView reloadData];
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    if (lineChartView.tag == AQCHartViewControllerChartTypeDot)
    {
        return [[[AQDataModel sharedInstance] dataForChartType:lineChartView.tag] count];
    }
    else if (lineChartView.tag == AQCHartViewControllerChartTypeBestFit)
    {
        return AQCHartViewControllerBestFitPointCount;
    }
    return 0;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    if (lineChartView.tag == AQCHartViewControllerChartTypeDot)
    {
        return [UIColor clearColor];
    }
    else if (lineChartView.tag == AQCHartViewControllerChartTypeBestFit)
    {
        return kQAColorChartLineColor;
    }
    return nil;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kAQCHartViewControllerLineWidth;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex
{
    return (lineChartView.tag == AQCHartViewControllerChartTypeDot);
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return kQAColorChartDotColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kAQCHartViewControllerDotRadius;
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewLineStyleSolid;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return NO;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    NSArray *data = [[AQDataModel sharedInstance] dataForChartType:((AQLineChartView *)lineChartView).chartIndex];
    
    if (lineChartView.tag == AQCHartViewControllerChartTypeDot)
    {
        AQDataPoint *dataPoint = (AQDataPoint *)[data objectAtIndex:horizontalIndex];
        return [dataPoint point].y;
    }
    else if (lineChartView.tag == AQCHartViewControllerChartTypeBestFit)
    {
        AQDataPoint *firstPoint = (AQDataPoint *)[data firstObject];
        AQDataPoint *lastPoint = (AQDataPoint *)[data lastObject];
        
        if (horizontalIndex == AQCHartViewControllerBestFitPoint1)
        {
            return firstPoint.point.y;
        }
        else if (horizontalIndex == AQCHartViewControllerBestFitPoint2)
        {
            return lastPoint.point.y;
        }
    }
    return 0.0f;
}

#pragma mark - AQChartViewDelegate

- (void)didSelectChartView:(AQChartView *)chartView
{
    AQChartDetailViewController *detailViewController = [[AQChartDetailViewController alloc] initWithChartType:chartView.dotChartView.chartIndex];
    AQBaseNavigationController *navigationController = [[AQBaseNavigationController alloc] initWithRootViewController:detailViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

@end

@implementation AQLineChartView

// Nothing to do here

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

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _chartLegendView = [[AQChartLegendView alloc] init];
        _chartLegendView.backgroundColor = [UIColor clearColor];
        [self addSubview:_chartLegendView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kAQColorChartTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [self addSubview:_titleLabel];
        
        _bestFitChartView = [[AQLineChartView alloc] init];
        _bestFitChartView.backgroundColor = kAQColorBaseBackgroundColor;
        [self addSubview:_bestFitChartView];

        _dotChartView = [[AQLineChartView alloc] init];
        _dotChartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_dotChartView];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chartViewTapped:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(kAQChartLegendViewMarginSize, self.bounds.origin.y, self.bounds.size.width - kAQChartLegendViewMarginSize, titleSize.height);

    self.chartLegendView.frame = self.bounds;
    
    self.bestFitChartView.frame = CGRectMake(kAQChartLegendViewMarginSize, self.bounds.origin.y + kAQChartLegendViewTitleHeight, self.bounds.size.width - kAQChartLegendViewMarginSize, self.bounds.size.height - kAQChartLegendViewMarginSize - kAQChartLegendViewTitleHeight);
    [self.bestFitChartView reloadData];

    self.dotChartView.frame = CGRectMake(kAQChartLegendViewMarginSize, self.bounds.origin.y + kAQChartLegendViewTitleHeight, self.bounds.size.width - kAQChartLegendViewMarginSize, self.bounds.size.height - kAQChartLegendViewMarginSize - kAQChartLegendViewTitleHeight);
    [self.dotChartView reloadData];
}

#pragma mark - Gestures

-  (void)chartViewTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectChartView:)])
    {
        [self.delegate didSelectChartView:self];
    }
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
            [chartView.bestFitChartView reloadData];
            [chartView.dotChartView reloadData];
        }
    }
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
            
            if (chartView.tag == AQDataModelChartType2)
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
    
    [self reloadData];
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
