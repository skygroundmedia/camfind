//
//  CFViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/18/14.
//  Copyright (c) 2014 IDapGroup. All rights reserved.
//

#import "CFViewController.h"

@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [TAGMANAGER startTiming];
    [TAGMANAGER pushOpenScreenEventWithScreenName:NSStringFromClass([self.view class])];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TAGMANAGER pauseTimingAndPushTimeWithScreenName:NSStringFromClass([self.view class])];
}

@end
