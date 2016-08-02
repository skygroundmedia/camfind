//
//  CFDetailViewController.h
//  CamFind
//
//  Created by Alexandr Chernov on 2/4/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFListViewController.h"

@interface CFDetailViewController : CFViewController
@property (nonatomic, retain) CFRecordModel         *model;
@property (nonatomic, assign) CFListViewController  *listViewController;

- (IBAction)onBack:(id)sender;
- (IBAction)onShare:(id)sender;

@end
