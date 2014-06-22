//
//  AQChartDetailViewController.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AQChartDetailViewController.h"

// Views
#import "AQDataPointTableCell.h"

// Strings
NSString * const kAQChartDetailViewControllerCellIdentifier = @"kAQChartDetailViewControllerCellIdentifier";

@interface AQChartDetailViewController ()

@property (nonatomic, assign) AQDataModelChartType chartType;

// Buttons
- (void)closeButtonPressed:(id)sender;

@end

@implementation AQChartDetailViewController

#pragma mark - Alloc/Init

- (id)initWithChartType:(AQDataModelChartType)chartType
{
    self = [super init];
    if (self)
    {
        _chartType = chartType;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kAQStringLabelClose style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonPressed:)];
    
    self.title = [NSString stringWithFormat:kAQStringLabelChartDetails, self.chartType + 1];
    
    [self.tableView registerClass:[AQDataPointTableCell class] forCellReuseIdentifier:kAQChartDetailViewControllerCellIdentifier];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AQDataModel sharedInstance] dataForChartType:self.chartType sorted:NO] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AQDataPointTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kAQChartDetailViewControllerCellIdentifier forIndexPath:indexPath];
    AQDataPoint *dataPoint = [[[AQDataModel sharedInstance] dataForChartType:self.chartType sorted:NO] objectAtIndex:indexPath.row];
    cell.leftLabel.text = [NSString stringWithFormat:@"%.1f", dataPoint.point.x];
    cell.rightLabel.text = [NSString stringWithFormat:@"%.1f", dataPoint.point.y];
    cell.backgroundColor = indexPath.row % 2 == 0 ? kQAColorDetailCellBackgroundColor : [UIColor whiteColor];
    return cell;
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
  