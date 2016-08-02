//
//  CFAppDelegate.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 IDapGroup. All rights reserved.
//

#import "CFAppDelegate.h"
#import <Crashlytics/Crashlytics.h>

@interface CFAppDelegate ()
@property (nonatomic, retain) TAGManager *tagManager;
@end

@implementation CFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [Crashlytics startWithAPIKey:@"c4dcde3d75563274731fe0519d4220e84b151323"];
    [Crashlytics startWithAPIKey:@"ed60b7f019cab46431bad5d3b5a09e299f1fab0c"];
    
    self.tagManager = [TAGManager instance];
    [self.tagManager.logger setLogLevel:kTAGLoggerLogLevelDebug];
    [TAGContainerOpener openContainerWithId:@"GTM-TS8WFN"   // own
//    [TAGContainerOpener openContainerWithId:@"GTM-K4KHDX"   // test
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferNonDefault
                                    timeout:nil
                                   notifier:TAGMANAGER];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [TAGMANAGER updateLocation];
}

@end
