//
//  SFListViewController.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "SFListViewController.h"
#import "SFListView.h"
#import "SFListCell.h"

@interface SFListViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, IDPModelObserver, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, readonly) SFListView                *listView;

@property (nonatomic, retain) UIImagePickerController   *imagePickerController;
@property (nonatomic, retain) SFCFPostImageContext      *postImageContext;
@property (nonatomic, retain) SFCFGetDescriptionContext *getDescriptionContext;
@property (nonatomic, retain) SFYQLGetSearchContext     *getSearchContext;

@property (nonatomic, retain) IDPLoadingView    *loadingView;
@property (nonatomic, retain) UIImage           *image;
@property (nonatomic, retain) NSURL             *imageURL;
@property (nonatomic, retain) NSArray           *dataSource;//SFRecordModels
@property (nonatomic, retain) SFListCell        *testListCell;
@end

@implementation SFListViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc{
    self.imagePickerController = nil;
    self.postImageContext = nil;
    self.getDescriptionContext = nil;
    self.getSearchContext = nil;
    
    self.loadingView = nil;
    self.image = nil;
    self.imageURL = nil;
    self.dataSource = nil;
    self.testListCell = nil;
    
    [super dealloc];
}

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:kSFDefaultImageName]];
    [self loadSavedFields];
    [self updateUI];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize (SFListView, listView)

- (void)setImage:(UIImage *)image {
    IDPNonatomicRetainPropertySynthesize(_image, image);
    self.listView.imageView.image = _image;
}

-(void)setPostImageContext:(SFCFPostImageContext *)postImageContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_postImageContext, postImageContext, self);
}

-(void)setGetDescriptionContext:(SFCFGetDescriptionContext *)getDescriptionContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getDescriptionContext, getDescriptionContext, self);
}

-(void)setGetSearchContext:(SFYQLGetSearchContext *)getSearchContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getSearchContext, getSearchContext, self);
}

-(void)setLoadingView:(IDPLoadingView *)loadingView {
    [self.loadingView removeFromSuperview];
    IDPNonatomicRetainPropertySynthesize(_loadingView, loadingView);
}

-(UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        IDPNonatomicRetainPropertySynthesize(_imagePickerController, [UIImagePickerController object]);
        _imagePickerController.delegate = self;
        [_imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    return _imagePickerController;
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onGetPhoto:(id)sender{
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)onSendPhoto:(id)sender{
    self.loadingView = [IDPLoadingView loadingViewInView:self.view];
    self.postImageContext = [SFCFPostImageContext object];
    self.postImageContext.imageURL = self.imageURL;
    [self.postImageContext load];
}

- (IBAction)onSetDefaultDescription:(id)sender {
    self.listView.imageDescriptionTextField.text = kSFDefaultDescription;
}

- (IBAction)onGetDescription:(id)sender {
    if (self.listView.keyLabel.text.length) {
        self.loadingView = [IDPLoadingView loadingViewInView:self.view];
        self.getDescriptionContext = [SFCFGetDescriptionContext object];
        self.getDescriptionContext.key = self.listView.keyLabel.text;
        [self.getDescriptionContext load];
    }
}

- (IBAction)onYahooSearch:(id)sender {
    if (self.listView.imageDescriptionTextField.text.length) {
        self.loadingView = [IDPLoadingView loadingViewInView:self.view];
        self.getSearchContext = [SFYQLGetSearchContext object];
        self.getSearchContext.searchString = self.listView.imageDescriptionTextField.text;
        [self.getSearchContext load];
    }
}


- (IBAction)onYahooShortSearch:(id)sender {
    if (self.listView.imageDescriptionTextField.text.length) {
        NSString *searchKeyword = [[self.listView.imageDescriptionTextField.text componentsSeparatedByString:@" "] lastObject];
        self.loadingView = [IDPLoadingView loadingViewInView:self.view];
        self.getSearchContext = [SFYQLGetSearchContext object];
        self.getSearchContext.searchString = searchKeyword;
        [self.getSearchContext load];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)prepareImagePickerController {
    self.imagePickerController = [UIImagePickerController new];
    self.imagePickerController.delegate = self;
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)saveImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageData writeToFile:[self.imageURL path] atomically:YES];
}

- (void)saveFields {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:self.listView.keyLabel.text forKey:kSFDefsTokenKey];
    [defs setObject:self.listView.imageDescriptionTextField.text forKey:kSFDefsImageDescriptionKey];
    [defs synchronize];
}

- (void)loadSavedFields {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    self.image = [UIImage imageWithContentsOfFile:[self.imageURL path]];
    self.listView.keyLabel.text = [defs objectForKey:kSFDefsTokenKey];
    self.listView.imageDescriptionTextField.text = [defs objectForKey:kSFDefsImageDescriptionKey];
}

- (void)updateUI {
    [self.listView tableContaineResults:self.dataSource.count];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    self.image = image;
    [self saveImage:image];
}

#pragma mark -
#pragma mark IDPModelObserver

-(void)modelDidLoad:(id)theModel {
    if (theModel == self.postImageContext) {
        self.listView.keyLabel.text = self.postImageContext.key;
        self.loadingView = nil;
    }
    if (theModel == self.getDescriptionContext) {
        self.listView.imageDescriptionTextField.text = self.getDescriptionContext.imageDescription;
        self.loadingView = nil;
    }
    if (theModel == self.getSearchContext) {
        self.dataSource = [SFXMLProcessor arrayFromXMLData:self.getSearchContext.xmlData];
        [self updateUI];
        [self.listView.tableView reloadData];
        self.loadingView = nil;
    }
    [self saveFields];
}

-(void)modelDidFailToLoad:(id)theModel {
    NSLog(@"fail to load - %@", [theModel class]);
    self.loadingView = nil;
}

#pragma mark -
#pragma mark UITableViewDelegate&DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classString = NSStringFromClass([SFListCell class]);
    SFListCell *cell = [tableView dequeueReusableCellWithIdentifier:classString];
    if (!cell) {
        cell = [UINib loadClass:[SFListCell class] withOwner:self];
    }
    [cell fillFromRecordModel:self.dataSource[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.testListCell) {
        self.testListCell = [UINib loadClass:[SFListCell class] withOwner:self];
    }
    return self.testListCell.bounds.size.height;
}

#pragma mark -
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
