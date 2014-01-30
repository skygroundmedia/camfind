//
//  SFAppDelegate.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFAppDelegate.h"
#import "SFSplashViewController.h"

@implementation SFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    SFSplashViewController *splashViewController = [SFSplashViewController viewControllerWithDefaultNib];
    
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:splashViewController] autorelease];
    [navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = navigationController;
    
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
