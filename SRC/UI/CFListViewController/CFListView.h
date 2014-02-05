//
//  CFListView.h
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

typedef enum {
    processStatusBase,
    processStatusSendingImage,
    processStatusGettingDescription,
    processStatusGettingYQL,
    processStatusCanceled
} processStatus;

@interface CFListView : UIView

@property (nonatomic, retain) IBOutlet UIImageView  *imageView;
@property (nonatomic, retain) IBOutlet UILabel      *tokenLabel;
@property (nonatomic, retain) IBOutlet UITextField  *imageDescriptionTextField;
@property (nonatomic, retain) IBOutlet UITableView  *tableView;
@property (nonatomic, retain) IBOutlet UIView       *tableViewBackView;
@property (nonatomic, retain) IBOutlet UILabel      *statusLabel;
@property (nonatomic, retain) IBOutlet UILabel      *tableViewStatusLabel;

- (void)tableViewHaveRows:(BOOL)haveRows;

@end
