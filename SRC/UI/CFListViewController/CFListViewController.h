//
//  CFListViewController.h
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFListView.h"

@interface CFListViewController : CFViewController

@property (nonatomic, readonly) CFListView        *listView;
@property (nonatomic, readonly) CFRecordModel     *selectedModel;

- (IBAction)onYahooSearch:(id)sender;

- (void)startImageProcessing;

@end
