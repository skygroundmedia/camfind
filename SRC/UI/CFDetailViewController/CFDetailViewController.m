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
@property (nonatomic, retain) NSURL *url;
@end

@implementation CFDetailViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc{
    self.url = nil;
    self.model = nil;

    [super dealloc];
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
        self.url = [NSURL URLWithString:self.model.url];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onBack:(id)sender {
    self.model = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

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
