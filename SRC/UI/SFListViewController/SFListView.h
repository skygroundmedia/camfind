//
//  SFListView.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

@interface SFListView : UIView

@property (nonatomic, retain) IBOutlet UIImageView  *imageView;
@property (nonatomic, retain) IBOutlet UILabel      *keyLabel;
@property (nonatomic, retain) IBOutlet UITextField  *imageDescriptionTextField;

@property (nonatomic, retain) IBOutlet UITableView  *tableView;
@property (nonatomic, retain) IBOutlet UILabel *noResultsLabel;

- (void)tableContaineResults:(BOOL)haveResults;

@end
