//
//  CFListCellWOImage.h
//  CamFind
//
//  Created by Alexandr Chernov on 2/5/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFListCellWOImage : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel      *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel      *descriptionLabel;

- (void)fillFromRecordModel:(CFRecordModel *)aModel;

@end
