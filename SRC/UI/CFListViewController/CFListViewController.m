//
//  CFListViewController.m
//  CamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFListViewController.h"
#import "CFListView.h"
#import "CFListCell.h"
#import "CFListCellWOImage.h"
#import "CFMainProcessor.h"
#import "CFDetailViewController.h"

@interface CFListViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, IDPModelObserver, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIActionSheetDelegate>
@property (nonatomic, readonly) CFListView                *listView;

@property (nonatomic, retain) UIImagePickerController   *imagePickerController;
@property (nonatomic, retain) IDPLoadingView            *loadingView;
@property (nonatomic, retain) UIActionSheet             *actionSheet;

@property (nonatomic, retain) NSArray           *dataSource;//SFRecordModels
@property (nonatomic, retain) CFListCell        *testListCell;
@property (nonatomic, retain) CFListCellWOImage *testListCellWOImage;
@property (nonatomic, retain) CFMainProcessor   *processor;
@property (nonatomic, assign) CFRecordModel     *selectedModel;

@end

@implementation CFListViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc{
    self.imagePickerController = nil;
    self.loadingView = nil;
    self.actionSheet = nil;
    self.dataSource = nil;
    self.testListCell = nil;
    self.testListCellWOImage = nil;
    self.processor = nil;
    
    [super dealloc];
}

#pragma mark
#pragma mark View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testListCell = [UINib loadClass:[CFListCell class] withOwner:self];
    self.testListCellWOImage = [UINib loadClass:[CFListCellWOImage class] withOwner:self];
    [self prepareActionSheet];
    self.dataSource = nil;
    [self.listView updateStatusWithProcessor:nil];
    [self startImageProcessing];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize (CFListView, listView)

- (void)setLoadingView:(IDPLoadingView *)loadingView {
    [self.loadingView removeFromSuperview];
    IDPNonatomicRetainPropertySynthesize(_loadingView, loadingView);
}

-(void)setProcessor:(CFMainProcessor *)processor {
    IDPNonatomicRetainModelSynthesizeWithObserving(_processor, processor, self);
    self.dataSource = nil;
}

-(void)setDataSource:(NSArray *)dataSource {
    IDPNonatomicRetainPropertySynthesize(_dataSource, dataSource);
    [self.listView tableViewHaveRows:dataSource.count];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onSetDefaultDescription:(id)sender {
    self.listView.searchBar.text = kSFDefaultDescription;
    [self onYahooSearch:nil];
}

- (IBAction)onYahooSearch:(id)sender {
    [self.listView.searchBar resignFirstResponder];
    [self showLoadingView];
    self.processor = [CFMainProcessor object];
    [self.processor searchImpctfulForDescription:self.listView.searchBar.text];
}

#pragma mark -
#pragma mark Public methods

- (void)startImageProcessing {
    [self startGettingPhoto];
}

#pragma mark -
#pragma mark Private methods

- (void)startGettingPhoto {
    [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)showLoadingView {
    self.loadingView = [IDPLoadingView loadingViewInView:self.listView.tableViewBackView];
}

- (void)showBage:(NSString *)bage {
    self.tabBarItem.badgeValue = bage;
}

- (void)showAllertOfEmptySearchResult {
    [[[[UIAlertView alloc] initWithTitle:kCFEmptySearchResultTitle
                                 message:kCFEmptySearchResultAlert
                                delegate:nil
                       cancelButtonTitle:@"Ok"
                       otherButtonTitles:nil] autorelease] show];
}

#pragma mark -
#pragma mark utils

- (void)prepareActionSheet {
    self.actionSheet = [[[UIActionSheet alloc] initWithTitle:kCFGetPhotoPrompt
                                                   delegate:self
                                          cancelButtonTitle:kCFGetPhotoCancel
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:kCFGetPhotoFromCamera,
                                                            kCFGetPhotoFromPhotoLibrary, nil] autorelease];
}

- (void)prepareImagePickerController {
    if (!self.imagePickerController) {
        self.imagePickerController = [UIImagePickerController new];
        self.imagePickerController.delegate = self;
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [CFMainProcessor saveImageToAlbum:image];
    }
    self.listView.testImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self showLoadingView];
    self.processor = [CFMainProcessor object];
    [self.processor sendImage:image];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)theModel {
    if (theModel == self.processor) {
        self.dataSource = self.processor.result;
        [self.listView.tableView reloadData];
        self.loadingView = nil;
        if (!self.dataSource.count) {
            [self showAllertOfEmptySearchResult];
        }
    }
}

- (void)modelDidFailToLoad:(id)theModel {
    if (theModel == self.processor) {
        NSLog(@"fail to load with status %@", [CFMainProcessor statusStrings][self.processor.status]);
        self.dataSource = nil;
        self.loadingView = nil;
    }
}

- (void)modelDidChange:(id)theModel {
    if (theModel == self.processor) {
        [self.listView updateStatusWithProcessor:self.processor];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate&DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFRecordModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = nil;
    if (model.imagePath) {
        NSString *classString = NSStringFromClass([CFListCell class]);
        cell = [tableView dequeueReusableCellWithIdentifier:classString];
        if (!cell) {
            cell = [UINib loadClass:[CFListCell class] withOwner:self];
        }
        [(CFListCell *)cell fillFromRecordModel:self.dataSource[indexPath.row]];
    } else {
        NSString *classString = NSStringFromClass([CFListCellWOImage class]);
        cell = [tableView dequeueReusableCellWithIdentifier:classString];
        if (!cell) {
            cell = [UINib loadClass:[CFListCellWOImage class] withOwner:self];
        }
        [(CFListCellWOImage *)cell fillFromRecordModel:self.dataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFRecordModel *model = self.dataSource[indexPath.row];
    if (model.imagePath) {
        return self.testListCell.bounds.size.height;
    } else {
        return self.testListCellWOImage.bounds.size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedModel = self.dataSource[indexPath.row];
    if (self.selectedModel.url.length) {
        [self performSegueWithIdentifier:@"toCFDetailViewController" sender:self];
    }
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self onYahooSearch:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
            
        default:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    BOOL isSourceTypeAvailable = [UIImagePickerController isSourceTypeAvailable:sourceType];
    if (buttonIndex != actionSheet.cancelButtonIndex && isSourceTypeAvailable) {
        [self prepareImagePickerController];
        self.imagePickerController.sourceType = sourceType;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark Seque methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CFDetailViewController *detailController = [segue destinationViewController];
    detailController.model = self.selectedModel;
}

@end
