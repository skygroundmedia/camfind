//
//  CFListCell.h
//  CamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFListCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UIImageView  *recordImageView;
@property (nonatomic, retain) IBOutlet UILabel      *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel      *descriptionLabel;

- (void)fillFromRecordModel:(CFRecordModel *)aModel;

@end
