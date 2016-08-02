//
//  CFListCellWOImage.m
//  CamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFListCellWOImage.h"

@interface CFListCellWOImage ()
@property (retain, nonatomic) CFRecordModel  *model;
@end

@implementation CFListCellWOImage

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.titleLabel = nil;
    self.descriptionLabel = nil;
    self.model = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)fillFromRecordModel:(CFRecordModel *)record {
    self.model = record;
    
    self.titleLabel.text = record.title;
    self.descriptionLabel.text = record.info;
}

@end
