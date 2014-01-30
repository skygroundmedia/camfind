//
//  SFRecordModel.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFRecordModel.h"
@interface SFRecordModel ()
@property (nonatomic, retain) UIImage  *image;
@end

@implementation SFRecordModel

- (BOOL)load {
    if (![super load]) {
        return NO;
    }
    
    NSDictionary* headers = @{};
    NSDictionary* parameters = @{};
    
    NSString *requestString = self.imagePath;
    
    [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:requestString];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[response rawBody]];
            if (image) {
                self.image = image;
                [self finishLoading];
            } else {
                [self failLoading];
            }
        });
    }];
    return YES;
}

@end
