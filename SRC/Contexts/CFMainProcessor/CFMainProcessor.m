//
//  CFMainProcessor.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 2/5/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFMainProcessor.h"
#import "CFPostImageContext.h"
#import "CFGetDescriptionContext.h"
#import "CFYQLGetSearchContext.h"
#import "CFXMLProcessor.h"
#import "UIImage+GRResize.h"

@interface CFMainProcessor () <IDPModelObserver>
@property (nonatomic, retain) CFPostImageContext      *postImageContext;
@property (nonatomic, retain) CFGetDescriptionContext *getDescriptionContext;
@property (nonatomic, retain) CFYQLGetSearchContext   *getSearchContext;

@property (nonatomic, retain) UIImage  *image;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *imageDescription;
@property (nonatomic, retain) NSData   *xmlData;
@property (nonatomic, retain) NSArray  *result;
@property (nonatomic, assign) int      getDescriptionRepeatCounter;

@property (nonatomic, assign) processorStatus  status;

@end

@implementation CFMainProcessor

#pragma mark -
#pragma mark Class methods

static NSArray *__statusStrings;

+ (NSString *)stringForStatus:(processorStatus)status {
    if (!__statusStrings) {
        __statusStrings = [@[@"processorReady",
                             @"processorStatusImageSending",
                             @"processorStatusImageSended",
                             @"processorStatusImageSendingFailed",
                             @"processorStatusTokenSending",
                             @"processorStatusTokenSended",
                             @"processorStatusTokenSendingFailed",
                             @"processorStatusYQLSending",
                             @"processorStatusYQLSended",
                             @"processorStatusYQLSendingFailed",
                             @"processorStatusProcessed"] retain];
    }
    return __statusStrings[status];
}

+ (void)saveImageToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}


#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.postImageContext = nil;
    self.getDescriptionContext = nil;
    self.getSearchContext = nil;
    
    self.image = nil;
    self.token = nil;
    self.imageDescription = nil;
    self.xmlData = nil;
    self.result = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)processingImage:(UIImage *)image {
    if (!image) {
        self.status = processorStatusImageSendingFailed;
        [self failLoading];
        return;
    }
    self.image = image;
    self.status = processorStatusImageSending;
    
    self.postImageContext = [CFPostImageContext object];
    self.postImageContext.image = [self convertImage:image];
    [self.postImageContext load];
}

- (void)processingToken:(NSString *)token {
    if (!token.length) {
        self.status = processorStatusTokenSendingFailed;
        [self failLoading];
        return;
    }
    self.token = token;
    self.status = processorStatusTokenSending;
    self.getDescriptionRepeatCounter = 0;
    [self startProcessingToken];
}

- (void)processingDescription:(NSString *)imageDescription {
    if (!imageDescription.length) {
        self.status = processorStatusYQLSendingFailed;
        [self failLoading];
        return;
    }
    self.imageDescription = imageDescription;
    self.status = processorStatusYQLSending;
    
    self.getSearchContext = [CFYQLGetSearchContext object];
    self.getSearchContext.searchString = imageDescription;
    [self.getSearchContext load];
}

#pragma mark -
#pragma mark Accessor methods

- (void)setStatus:(processorStatus)status {
    _status = status;
    [self notifyObserversOfChanges];
}

-(void)setPostImageContext:(CFPostImageContext *)postImageContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_postImageContext, postImageContext, self);
}

-(void)setGetDescriptionContext:(CFGetDescriptionContext *)getDescriptionContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getDescriptionContext, getDescriptionContext, self);
}

-(void)setGetSearchContext:(CFYQLGetSearchContext *)getSearchContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getSearchContext, getSearchContext, self);
}

#pragma mark -
#pragma mark Private methods

- (void)startProcessingToken {
    if (++self.getDescriptionRepeatCounter >= kCFGetDescriptionRepeatCount) {
        self.status = processorStatusTokenSendingFailed;
        [self failLoading];
    } else {
        NSLog(@"try %d", self.getDescriptionRepeatCounter);
        self.getDescriptionContext = [CFGetDescriptionContext object];
        self.getDescriptionContext.key = self.token;
        [self.getDescriptionContext load];
    }
}

- (void)processXML:(NSData *)xmlData {
    self.result = [CFXMLProcessor arrayFromXMLData:xmlData];
    self.status = processorStatusProcessed;
    [self finishLoading];
}

- (UIImage *)convertImage:(UIImage *)image {
    double scale = kCFMaxImageSize / MAX(image.size.height, image.size.width);
    if (scale < 1.) {
        image = [image scaledImage:scale];
    }
    return image;
}

#pragma mark -
#pragma mark IDPModelObserver methods

- (void)modelDidLoad:(id)theModel {
    if (theModel == self.postImageContext) {
        self.token = self.postImageContext.key;
        self.status = processorStatusImageSendingProcessed;
        [self processingToken:self.postImageContext.key];
    }
    if (theModel == self.getDescriptionContext) {
        if (self.getDescriptionContext.imageDescription) {
            self.imageDescription = self.getDescriptionContext.imageDescription;
            self.status = processorStatusTokenSendingProcessed;
            [self processingDescription:self.getDescriptionContext.imageDescription];
        } else {
            [self performSelector:@selector(startProcessingToken)
                       withObject:self
                       afterDelay:kCFGetDescriptionDelay];
        }
    }
    if (theModel == self.getSearchContext) {
        self.xmlData = self.getSearchContext.xmlData;
        self.status = processorStatusYQLSendingProcessed;
        [self processXML:self.getSearchContext.xmlData];
    }
}

- (void)modelDidFailToLoad:(id)theModel {
    if (theModel == self.postImageContext) {
        self.status = processorStatusImageSendingFailed;
    }
    if (theModel == self.getDescriptionContext) {
        self.status = processorStatusTokenSendingFailed;
    }
    if (theModel == self.getSearchContext) {
        self.status = processorStatusYQLSendingFailed;
    }
    [self failLoading];
}

@end
