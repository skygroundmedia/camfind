//
//  CFPostImageContext.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFPostImageContext.h"

@interface CFPostImageContext ()
@property (nonatomic, retain) NSString *key;
@end

@implementation CFPostImageContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.image = nil;
    self.key = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (!self.image || ![super load]) {
        [self failLoading];
        return NO;
    }

    NSURL *imageURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:kSFDefaultImageName]];
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
    [imageData writeToFile:[imageURL path] atomically:YES];
    
    NSDictionary* headers = @{kSFCFAuthHeader: kSFCFAuthKey};
    NSDictionary* parameters = @{kSFCFParameterLocale   : kSFCFParameterLocaleKey,
                                 kSFCFParameterLanguage : kSFCFParameterLanguageKey,
                                 kSFCFParameterIMage    : imageURL};
    NSString *requestString = [kSFCamFindHost stringByAppendingPathComponent:kSFCFpostImagePath];
    
    [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:requestString];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary* json = [[response body] JSONObject];
            NSString *errorFromJSON = json[kSFCFJSONError];
            if (error || errorFromJSON) {
                [self failLoading];
            } else {
                self.key = json[kSFCFJSONToken];
                [self finishLoading];
            }
        });
    }];
    
    return YES;
}

@end
