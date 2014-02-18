//
//  CFMainViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFListViewController.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController

#pragma mark -
#pragma mark Initializations and Deallocations


#pragma mark -
#pragma mark TabBar methods

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (self.selectedViewController.tabBarItem == item && [self.selectedViewController isKindOfClass:[CFListViewController class]]) {
        [(CFListViewController *)self.selectedViewController startImageProcessing];
    }
}

@end
