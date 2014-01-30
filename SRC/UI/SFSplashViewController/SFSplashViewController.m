//
//  SFSplashViewController.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFSplashViewController.h"
#import "SFListViewController.h"

@interface SFSplashViewController ()

@end

@implementation SFSplashViewController

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanTempDirectory];
    [self pushListViewControllerWithDelay:1.5];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onGo:(id)sender {
    [self pushListViewController];
}

#pragma mark -
#pragma mark Private methods

- (void)pushListViewControllerWithDelay:(float)delay {
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self pushListViewController];
    });
}

- (void)pushListViewController {
    SFListViewController *listViewController = [SFListViewController defaultNibController];
    [self.navigationController pushViewController:listViewController animated:YES];
}

- (void)cleanTempDirectory {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray * filelist = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
    for (NSString * filePath in filelist) {
        [manager removeItemAtPath:filePath error:nil];
    }
}

@end
