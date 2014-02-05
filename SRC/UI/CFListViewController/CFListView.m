//
//  CFListView.m
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFListView.h"

@implementation CFListView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageView = nil;
    self.tokenLabel = nil;
    self.imageDescriptionTextField = nil;
    self.tableView = nil;
    self.statusLabel = nil;
    self.tableViewBackView = nil;
    self.tableViewStatusLabel = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)tableViewHaveRows:(BOOL)haveRows {
    self.tableView.alpha = haveRows;
    self.tableViewStatusLabel.alpha = !haveRows;
    self.tableViewStatusLabel.text = @"no data for show";
}

@end
