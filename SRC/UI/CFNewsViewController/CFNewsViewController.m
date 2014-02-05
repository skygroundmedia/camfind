//
//  CFNewsViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 2/3/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFNewsViewController.h"
#import "CFNewsView.h"

@interface CFNewsViewController () <IDPModelObserver, UIWebViewDelegate>
@property (nonatomic, readonly) CFNewsView      *newsView;
@property (nonatomic, retain) NSURL             *url;
@end

@implementation CFNewsViewController

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
    self.url = [NSURL URLWithString:kCFNewsURLString];
    [self.newsView.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize (CFNewsView, newsView)

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
