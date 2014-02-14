//
//  CFTAGManager.h
//  CamFind
//
//  Created by Alexandr Chernov on 2/14/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//
#import "TAGContainer.h"
#import "TAGManager.h"

@interface CFTAGManager : NSObject

+ (void)setContainer:(TAGContainer *)container;

+ (void)startTimer;
+ (void)pauseTimer;
+ (void)sendTime;

+ (void)sendCamFindPost;
+ (void)sendCamFindDescription:(NSString *)imageDescription;
+ (void)sendUserLocation;

@end
