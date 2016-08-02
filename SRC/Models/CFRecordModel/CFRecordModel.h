//
//  CFRecordModel.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

@interface CFRecordModel : IDPModel
@property (nonatomic, retain)   NSString *title;
@property (nonatomic, retain)   NSString *info;
@property (nonatomic, retain)   NSString *imagePath;
@property (nonatomic, retain)   NSString *url;
@property (nonatomic, readonly) UIImage  *image;

- (BOOL)load;//async-loading image
@end
