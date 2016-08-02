//
//  CFDetailView.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/4/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFDetailView.h"

@implementation CFDetailView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.webView = nil;

    [super dealloc];
}

@end
