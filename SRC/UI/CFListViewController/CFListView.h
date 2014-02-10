//
//  CFListView.h
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFMainProcessor.h"

@interface CFListView : UIView

@property (nonatomic, retain) IBOutlet UITextField  *imageDescriptionTextField;
@property (nonatomic, retain) IBOutlet UITableView  *tableView;
@property (nonatomic, retain) IBOutlet UIView       *tableViewBackView;
@property (nonatomic, retain) IBOutlet UIView       *statusBackView;
@property (nonatomic, retain) IBOutlet UIView       *statusIndicatorView;
@property (nonatomic, retain) IBOutlet UILabel      *statusLabel;

@property (nonatomic, retain) IBOutlet UIImageView  *testImageView;
@property (nonatomic, retain) IBOutlet UILabel      *testTokenLabel;
@property (nonatomic, retain) IBOutlet UILabel      *testStatusLabel;

- (void)tableViewHaveRows:(BOOL)haveRows;
- (void)updateStatusWithProcessor:(CFMainProcessor *)processor;

@end
