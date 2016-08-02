//
//  CFXMLProcessor.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "CFTAGManager.h"
#import "TAGDataLayer.h"
#define REFRESHTIME 30
#define DATALAYER [TAGManager instance].dataLayer
@interface CFTAGManager () <CLLocationManagerDelegate>
@property (nonatomic, retain) NSDate            *startTime;
@property (nonatomic, retain) TAGContainer      *container;
@property (nonatomic, retain) NSTimer           *refreshTimer;
@property (nonatomic, retain) CLLocationManager *gps;
@property (nonatomic, retain) CLLocation        *location;
@end

@implementation CFTAGManager

+ (CFTAGManager *)sharedInstance {
    static CFTAGManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    return __sharedInstance;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)init {
    if (self = [super init]) {
//        self.gps = [[CLLocationManager new] autorelease];
//        self.gps.delegate = self;
//        self.gps.desiredAccuracy = kCLLocationAccuracyBest;
//        [self.gps startUpdatingLocation];
    }
    return self;
}

- (void)dealloc {
    self.container = nil;
    self.startTime = nil;
    self.refreshTimer = nil;
    self.gps = nil;
    self.location = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)updateLocation {
//    [self.gps startUpdatingLocation];
}

- (void)containerAvailable:(TAGContainer *)container {
    self.container = container;
//    #warning TOREMOVE, testing
//    if (!self.refreshTimer) {
//        self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:REFRESHTIME
//                                                             target:self
//                                                           selector:@selector(refreshContainer:)
//                                                           userInfo:nil
//                                                            repeats:YES];
//        [self refreshContainer:nil];
//    }
}

- (void)sendCamFindPost {
    [DATALAYER push:@{@"event": @"camFindRequest"}];
}

- (void)sendCamFindDescription:(NSString *)imageDescription {
    if (imageDescription.length) {
        [DATALAYER push:@{@"event": @"imageDescriptionRecieved", @"imageDescription": imageDescription}];
    }
}

- (void)sendImpctfulSearch:(NSString *)searchString {
    if (searchString.length) {
        [DATALAYER push:@{@"event": @"searchImpctful", @"searchString": searchString}];
    }
}

- (void)sendEmptyImpctfulSearch:(NSString *)searchString {
    if (searchString.length) {
        [DATALAYER push:@{@"event": @"emptyImpctfulSearch", @"searchString": searchString}];
    }
}

- (void)pushOpenScreenEventWithScreenName:(NSString *)screenName {
    [DATALAYER push:@{@"event": @"openScreen",
                 @"screenName": screenName}];
}

- (void)startTiming {
    if (!self.startTime) {
        self.startTime = [NSDate date];
    }
}

- (void)pauseTimingAndPushTimeWithScreenName:(NSString *)screenName {
    if (self.startTime) {
        [DATALAYER push:@{@"event": @"timing",
                          @"screenName": screenName,
                          @"value": @(-[self.startTime timeIntervalSinceNow])}];
        self.startTime = nil;
    }
}

#pragma mark -
#pragma mark Private methods

- (void)refreshContainer:(NSTimer *)timer {
    [self.container refresh];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)locationManager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation;
    [self.gps stopUpdatingLocation];
}

@end
