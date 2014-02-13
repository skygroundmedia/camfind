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

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
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

- (IBAction)onShare:(id)sender {
    UIActivityViewController *activityController = [[[UIActivityViewController alloc] initWithActivityItems:@[self.url]
                                                                                     applicationActivities:nil] autorelease];
    [self presentViewController:activityController animated:YES completion:nil];

}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.navigationItem.title = webView.request.URL.absoluteString;
}

@end
