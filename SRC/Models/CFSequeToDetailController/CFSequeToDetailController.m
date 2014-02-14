//
//  CFSequeToDetailController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/13/14.
//  Copyright (c) 2014 IDapGroup. All rights reserved.
//

#import "CFSequeToDetailController.h"
#import "CFListViewController.h"
#import "CFDetailViewController.h"

@implementation CFSequeToDetailController

- (void)perform {
    CFListViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    CGPoint originalCenter = sourceViewController.listView.mainBackView.center;

    CGRect oldFrame = sourceViewController.tabBarController.view.frame;
    CGRect newFrame = oldFrame;
    newFrame.origin.y = oldFrame.size.height + 50;
    destinationViewController.view.frame = newFrame;
    
    [sourceViewController.tabBarController.view addSubview:destinationViewController.view];

    [UIView animateWithDuration:kCFDetailTransitionDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                                destinationViewController.view.frame = oldFrame;
                                sourceViewController.listView.mainBackView.transform = CGAffineTransformMakeScale(kCFDetailTransitionScale, kCFDetailTransitionScale);
                                sourceViewController.listView.mainBackView.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview];
                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL];
                     }];
}

@end
