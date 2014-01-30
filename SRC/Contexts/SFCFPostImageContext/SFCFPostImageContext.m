//
//  SFCFPostImageContext.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFCFPostImageContext.h"

@interface SFCFPostImageContext ()
@property (nonatomic, retain) NSString                  *key;
@end

@implementation SFCFPostImageContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageURL = nil;
    self.key = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (![self checkForImageFile] || ![super load]) {
        [self failLoading];
        return NO;
    }
    
    NSDictionary* headers = @{kSFCFAuthHeader: kSFCFAuthKey};
    NSDictionary* parameters = @{kSFCFParameterLocale   : kSFCFParameterLocaleKey,
                                 kSFCFParameterLanguage : kSFCFParameterLanguageKey,
                                 kSFCFParameterIMage    : self.imageURL};
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

#pragma mark -
#pragma mark Private

- (BOOL)checkForImageFile {
    if (!self.imageURL) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:self.imageURL.path];
}

@end
