//
//  CFTAGManager.h
//  CamFind
//
//  Created by Alexandr Chernov on 2/14/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//
#import "TAGContainer.h"
#import "TAGManager.h"
#import "TAGContainerOpener.h"

#define TAGMANAGER [CFTAGManager sharedInstance]

@interface CFTAGManager : NSObject <TAGContainerOpenerNotifier>

@property (nonatomic, readonly) TAGContainer *container;

+ (CFTAGManager *)sharedInstance;

//tag delegate
- (void)containerAvailable:(TAGContainer *)container;

//location service
- (void)updateLocation;

//events
- (void)sendCamFindPost;
- (void)sendCamFindDescription:(NSString *)imageDescription;
- (void)sendImpctfulSearch:(NSString *)searchString;
- (void)sendEmptyImpctfulSearch:(NSString *)searchString;

//app views
- (void)pushOpenScreenEventWithScreenName:(NSString *)screenName;

//timing
- (void)startTiming;
- (void)pauseTimingAndPushTimeWithScreenName:(NSString *)screenName;

@end
