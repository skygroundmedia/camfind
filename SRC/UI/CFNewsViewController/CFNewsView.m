//
//  CFNewsView.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFNewsView.h"

@implementation CFNewsView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.webView = nil;

    [super dealloc];
}

@end
