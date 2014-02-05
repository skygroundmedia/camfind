//
//  CFYQLGetSearchContext.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

@interface CFYQLGetSearchContext : IDPModel

@property (nonatomic, retain)   NSString    *searchString;
@property (nonatomic, readonly) NSData      *xmlData;

@end
