//
//  AppDelegate.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/9/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AppDelegate.h"

// Controllers
#import "AQChartViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[AQChartViewController alloc] init]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
