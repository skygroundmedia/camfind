//
//  SFListView.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFListView.h"

@implementation SFListView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageView = nil;
    self.keyLabel = nil;
    self.imageDescriptionTextField = nil;
    self.tableView = nil;
    self.noResultsLabel = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)tableContaineResults:(BOOL)containeResults {
        self.tableView.alpha = containeResults;
        self.noResultsLabel.alpha = !containeResults;
}


@end
