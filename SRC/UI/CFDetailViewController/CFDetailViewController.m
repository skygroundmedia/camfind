//
//  CFDetailViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFDetailViewController.h"
#import "CFDetailView.h"

@interface CFDetailViewController () <UIWebViewDelegate>
@property (nonatomic, retain) NSURL  *url;
@end

@implementation CFDetailViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc{
    self.url = nil;
    self.model = nil;

    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.detailView.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}


#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize (CFDetailView, detailView)

-(void)setModel:(CFRecordModel *)model {
    IDPNonatomicRetainPropertySynthesize(_model, model);
    if (self.model.url) {
        self.navigationItem.title = model.title;
        self.url = [NSURL URLWithString:self.model.url];
        [self.detailView.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onBack:(id)sender {   
    self.model = nil;
    [self backToListViewController];
}

- (IBAction)onShare:(id)sender {
    UIActivityViewController *activityController = [[[UIActivityViewController alloc] initWithActivityItems:@[self.url]
                                                                                     applicationActivities:nil] autorelease];
    [self presentViewController:activityController animated:YES completion:nil];

}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    self.navigationItem.title = webView.request.URL.absoluteString;
}

#pragma mark -
#pragma mark private methods

- (void)backToListViewController {
    UIImageView *screenshot = [self screenshot];
    screenshot.frame = self.navigationController.view.frame;
    [self.listViewController.tabBarController.view addSubview:screenshot];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
    CGRect frame = screenshot.frame;
    frame.origin.y = frame.size.height;
    
    CGPoint originalCenter = self.listViewController.listView.mainBackView.center;
    
    [UIView animateWithDuration:kCFDetailTransitionDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         screenshot.frame = frame;
                         self.listViewController.listView.mainBackView.transform = CGAffineTransformMakeScale(1, 1);
                         self.listViewController.listView.mainBackView.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         [screenshot removeFromSuperview];
                     }];
}

- (UIImageView *)screenshot {
    CGSize imageSize = self.navigationController.view.frame.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
    screenshot.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    return screenshot;
}

@end
