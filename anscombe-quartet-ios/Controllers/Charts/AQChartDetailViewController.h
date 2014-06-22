//
//  AQChartDetailViewController.h
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model
#import "AQDataModel.h"

@interface AQChartDetailViewController : UITableViewController

- (id)initWithChartType:(AQDataModelChartType)chartType;

@end
