//
//  CFYQLGetSearchContext.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFYQLGetSearchContext.h"


@interface CFYQLGetSearchContext ()
@property (nonatomic, retain) NSData      *xmlData;;
@end

@implementation CFYQLGetSearchContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.searchString = nil;
    self.xmlData = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (!self.searchString || ![super load]) {
        [self failLoading];
        return NO;
    }
    NSString *searchString = [self.searchString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    NSDictionary* headers = @{};
    NSString *yqlQuery = [NSString stringWithFormat:kSFYahooQueryFormat, searchString];
    NSDictionary* parameters = @{kSFYahooParameterQuery: yqlQuery};
    
    [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:kSFYahooPath];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (error || ![response rawBody]) {
                [self failLoading];
            } else {
                self.xmlData = [response rawBody];
                [self finishLoading];
            }
        });
    }];
    
    return YES;
}

@end
