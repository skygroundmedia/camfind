//
//  CFAppDelegate.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 IDapGroup. All rights reserved.
//

#import "CFAppDelegate.h"
#import <Crashlytics/Crashlytics.h>

@interface ContainerNotifier : NSObject<TAGContainerOpenerNotifier>
@property (atomic, strong) TAGContainer *container;
@end
@implementation ContainerNotifier
- (void)containerAvailable:(TAGContainer *)container {
    [CFTAGManager setContainer:container];
}
@end

@interface CFAppDelegate ()
@property (nonatomic, retain) TAGManager *tagManager;
@end

@implementation CFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Crashlytics startWithAPIKey:@"c4dcde3d75563274731fe0519d4220e84b151323"];

    self.tagManager = [TAGManager instance];
    /*
     * Opens a container and calls notifier when container is opened.
     *
     * @param containerId The ID of the container to load.
     * @param tagManager The TAGManager instance for getting the container.
     * @param openType The choice of how to open the container.
     * @param timeout The timeout period (default is 2.0 seconds).
     * @param notifier The notifier which will be called when the container is
     *        available.
     */
    [TAGContainerOpener openContainerWithId:@"GTM-TS8WFN"   // Update with your Container ID.
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferNonDefault
                                    timeout:nil
                                   notifier:[[ContainerNotifier alloc] init]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"ResignActive");
    [CFTAGManager pauseTimer];
    [CFTAGManager sendTime];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [CFTAGManager startTimer];
}

@end
