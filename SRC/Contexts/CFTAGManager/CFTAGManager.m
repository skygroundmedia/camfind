//
//  CFXMLProcessor.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFTAGManager.h"
#import "TAGDataLayer.h"

NSDate *__startTime;
double __timeInterval;
TAGContainer *__container;

@interface CFTAGManager ()
@end

@implementation CFTAGManager

+ (void)setContainer:(TAGContainer *)container {
    IDPNonatomicRetainPropertySynthesize(__container, container);
}

+ (void)startTimer {
    if (!__startTime) {
        __startTime = [[NSDate dateWithTimeIntervalSinceNow:0] retain];
    }
}

+ (void)pauseTimer {
    if (__startTime) {
        __timeInterval -= [__startTime timeIntervalSinceNow];
        [__startTime release];
        __startTime = nil;
    }
}

+ (void)sendTime {
    [self pauseTimer];
    if (__timeInterval >0 ) {
//        TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
//        [dataLayer push:@{@"event": @"openScreen", @"screenName": @"Home Screen"}];
    
        
        __timeInterval = 0;
    }
    [self startTimer];
}

+ (void)sendCamFindPost {
    TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
    [dataLayer push:@{@"event": @"camFindRequest"}];
}

+ (void)sendCamFindDescription:(NSString *)imageDescription {
    if (imageDescription.length) {
        TAGDataLayer *dataLayer = [TAGManager instance].dataLayer;
        [dataLayer push:@{@"event": @"imageDescriptionRecieved", @"imageDescription": imageDescription}];
    }
}

+ (void)sendUserLocation {
    
}

@end
