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
    self.imageDescriptionTextField = nil;
    self.tableView = nil;
    self.tableViewBackView = nil;
    self.statusBackView = nil;
    self.statusIndicatorView = nil;
    self.statusLabel = nil;

    self.testImageView = nil;
    self.testTokenLabel = nil;
    self.testStatusLabel = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)tableViewHaveRows:(BOOL)haveRows {
    self.tableView.alpha = haveRows;
//    self.tableViewStatusLabel.alpha = !haveRows;
//    self.tableViewStatusLabel.text = @"no data for show";
}

-(void)updateStatusWithProcessor:(CFMainProcessor *)processor {
    CGRect frame = self.statusIndicatorView.frame;
    if (processor) {
        self.statusLabel.text = [CFMainProcessor statusStrings][processor.status];
        frame.size.width = self.statusBackView.frame.size.width * [processor indicatorWidth];
    } else {
        self.statusLabel.text = [CFMainProcessor statusStrings][processorStatusReady];
        frame.size.width = 0;
    }
    self.statusIndicatorView.frame = frame;
    if (processor.status == processorStatusDescriptionGettingComplete) {
        self.imageDescriptionTextField.text = processor.imageDescription;
    }
    if (processor.status == processorStatusImageSendingComplete) {
        self.testTokenLabel.text = processor.token;
    }
}

@end
