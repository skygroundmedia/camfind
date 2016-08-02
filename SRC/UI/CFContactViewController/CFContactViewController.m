//
//  CFContactViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFContactViewController.h"
#import "CFContactView.h"

@interface CFContactViewController () <IDPModelObserver, UIWebViewDelegate>
@property (nonatomic, readonly) CFContactView      *contactView;
@property (nonatomic, retain) NSURL             *url;
@end

@implementation CFContactViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc{
    self.url = nil;

    [super dealloc];
}

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:kCFFeedbackURLString];
    [self.contactView.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize (CFContactView, contactView)

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
