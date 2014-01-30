//
//  SFListCell.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFListCell.h"

@interface SFListCell () <IDPModelObserver>
@property (retain, nonatomic) SFRecordModel  *model;
@property (nonatomic, retain) IDPLoadingView *loadingView;
@end

@implementation SFListCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.recordImageView = nil;
    self.titleLabel = nil;
    self.descriptionLabel = nil;
    
    self.model = nil;
    self.loadingView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessor methods

- (void)setModel:(SFRecordModel *)model {
    IDPNonatomicRetainModelSynthesizeWithObserving(_model, model, self);
}

#pragma mark -
#pragma mark Public methods

- (void)fillFromRecordModel:(SFRecordModel *)record {
    self.model = record;
    
    self.titleLabel.text = record.title;
    self.descriptionLabel.text = record.info;
    
    if (record.image) {
        self.recordImageView.image = record.image;
    } else {
        self.loadingView = [IDPLoadingView loadingViewInView:self.recordImageView];
        [self.model load];
    }
}

#pragma mark -
#pragma mark UITableViewCell methods

-(void)prepareForReuse {
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
    self.recordImageView.image = nil;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(SFRecordModel *)theModel {
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
    self.recordImageView.image = theModel.image;
}

- (void)modelDidFailToLoad:(id)theModel {
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
}



@end
