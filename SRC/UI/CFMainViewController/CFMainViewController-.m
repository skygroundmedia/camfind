//
//  CFMainViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFNewsViewController.h"
#import "CFContactViewController.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    [self baseInit];
    return self;
}

- (void)baseInit {
    [super baseInit];

    
    CFNewsViewController *viewController1 = [CFNewsViewController defaultNibController];
    viewController1.title = @"news";
    viewController1.tabBarItem.image = nil;
    [self addChildViewController:viewController1];
    
    CFContactViewController *viewController3 = [CFContactViewController defaultNibController];
    viewController3.title = @"Contact";
    viewController3.tabBarItem.image = nil;
    [self addChildViewController:viewController3];
}

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark -
#pragma mark Interface Handling

#pragma mark -
#pragma mark Private methods


@end
