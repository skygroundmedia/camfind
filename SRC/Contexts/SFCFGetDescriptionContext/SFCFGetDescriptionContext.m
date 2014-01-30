//
//  SFCFGetDescriptionContext.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFCFGetDescriptionContext.h"

@interface SFCFGetDescriptionContext ()
@property (nonatomic, retain) NSString    *imageDescription;
@end

@implementation SFCFGetDescriptionContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.key = nil;
    self.imageDescription = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (!self.key || ![super load]) {
        [self failLoading];
        return NO;
    }
    
    NSDictionary* headers = @{kSFCFAuthHeader: kSFCFAuthKey};
    NSDictionary* parameters = @{};
    
    NSString *requestString = [kSFCamFindHost stringByAppendingPathComponent:[NSString stringWithFormat:kSFCFgetDescriptionPathFormat, self.key]];
    
    [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:requestString];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary* json = [[response body] JSONObject];
            NSString *errorFromJSON =self.key = json[kSFCFJSONError];
            if (error || errorFromJSON) {
                [self failLoading];
            } else {
                NSString *status = json[kSFCFJSONStatus];
                if ([status isEqualToString:kSFCFJSONStatusCompleted]) {
                    self.imageDescription = json[kSFCFJSONName];
                } else {
                    self.imageDescription = status;
                }
                [self finishLoading];
            }
        });
    }];
    
    return YES;
}

@end
