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
#import "CFImpctfulSearchContext.h"
#import "CFXMLProcessor.h"
#import "UIImage+GRResize.h"

@interface CFMainProcessor () <IDPModelObserver>
@property (nonatomic, retain) CFPostImageContext      *postImageContext;
@property (nonatomic, retain) CFGetDescriptionContext *getDescriptionContext;
@property (nonatomic, retain) CFImpctfulSearchContext *getSearchContext;

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

static NSArray *__processorStatusStrings;

+ (NSArray *)statusStrings {
    if (!__processorStatusStrings) {
        __processorStatusStrings = @[kCFProcessorReady,
                                     kCFProcessorImageSending,
                                     kCFProcessorImageSendingComplete,
                                     kCFProcessorImageSendingFailed,
                                     kCFProcessorGettingDescription,
                                     kCFProcessorGettingDescriptionComplete,
                                     kCFProcessorGettingDescriptionFailed,
                                     kCFProcessorImpctfulSearching,
                                     kCFProcessorImpctfulSearchingComplete,
                                     kCFProcessorImpctfulSearchingFailed,
                                     kCFProcessorComplete];
        [__processorStatusStrings retain];
    }
    return __processorStatusStrings;
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

- (void)sendImage:(UIImage *)image {
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

- (void)getDescriptionWithToken:(NSString *)token {
    if (!token.length) {
        self.status = processorStatusDescriptionGettingFailed;
        [self failLoading];
        return;
    }
    self.token = token;
    self.status = processorStatusDescriptionGetting;
    self.getDescriptionRepeatCounter = 0;
    [self startDescriptionGetting];
}

- (void)searchImpctfulForDescription:(NSString *)imageDescription {
    if (!imageDescription.length) {
        self.status = processorStatusImpctfulSearchingFailed;
        [self failLoading];
        return;
    }
    self.imageDescription = imageDescription;
    self.status = processorStatusImpctfulSearching;
    
    self.getSearchContext = [CFImpctfulSearchContext object];
    self.getSearchContext.searchString = imageDescription;
    [self.getSearchContext load];
}

- (float)indicatorWidth {
    float width = 0;
    switch (self.status) {
            
        case processorStatusReady:
            width = [self frameWidth:3 :0 :0];
            break;
            
        case processorStatusImageSending:
            width = [self frameWidth:0 :1 :2];
            break;
        case processorStatusImageSendingComplete:
            width = [self frameWidth:1 :0 :0];
            break;
        case processorStatusImageSendingFailed:
            width = [self frameWidth:1 :0 :0];
            break;
            
        case processorStatusDescriptionGetting:
            width = [self frameWidth:1 :self.getDescriptionRepeatCounter :kCFGetDescriptionRepeatCount];
            break;
        case processorStatusDescriptionGettingComplete:
            width = [self frameWidth:2 :0 :0];
            break;
        case processorStatusDescriptionGettingFailed:
            width = [self frameWidth:1 :self.getDescriptionRepeatCounter :kCFGetDescriptionRepeatCount];
            break;
            
        case processorStatusImpctfulSearching:
            width = [self frameWidth:2 :1 :2];
            break;
        case processorStatusImpctfulSearchingComplete:
            width = [self frameWidth:3 :0 :0];
            break;
        case processorStatusImpctfulSearchingFailed:
            width = [self frameWidth:3 :0 :0];
            break;
            
        default:
            width = 1;
            break;
    }
    return width;
}

#pragma mark -
#pragma mark Accessor methods

- (void)setStatus:(processorStatus)status {
    _status = status;
    [self notifyObserversOfChanges];
}

- (void)setGetDescriptionRepeatCounter:(int)getDescriptionRepeatCounter {
    _getDescriptionRepeatCounter = getDescriptionRepeatCounter;
    if (getDescriptionRepeatCounter) {
        [self notifyObserversOfChanges];
    }
}

-(void)setPostImageContext:(CFPostImageContext *)postImageContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_postImageContext, postImageContext, self);
}

-(void)setGetDescriptionContext:(CFGetDescriptionContext *)getDescriptionContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getDescriptionContext, getDescriptionContext, self);
}

-(void)setGetSearchContext:(CFImpctfulSearchContext *)getSearchContext {
    IDPNonatomicRetainModelSynthesizeWithObserving(_getSearchContext, getSearchContext, self);
}

#pragma mark -
#pragma mark Private methods

- (void)startDescriptionGetting {
    if (self.getDescriptionRepeatCounter+1 > kCFGetDescriptionRepeatCount) {
        self.status = processorStatusDescriptionGettingFailed;
        [self failLoading];
    } else {
        self.getDescriptionRepeatCounter++;
        [self performSelector:@selector(doDescriptionGetting) withObject:self afterDelay:kCFGetDescriptionDelay];
    }
}

- (void)doDescriptionGetting {
    self.getDescriptionContext = [CFGetDescriptionContext object];
    self.getDescriptionContext.key = self.token;
    [self.getDescriptionContext load];
}


- (void)processXML:(NSData *)xmlData {
    self.result = [CFXMLProcessor arrayFromXMLData:xmlData];
    self.status = processorStatusComplete;
    [self finishLoading];
}

- (UIImage *)convertImage:(UIImage *)image {
    double scale = kCFMaxImageSize / MAX(image.size.height, image.size.width);
    if (scale < 1.) {
        image = [image scaledImage:scale];
    }
    return image;
}

- (float)frameWidth:(int)a :(int)b :(int)c {
    float width = 1.0 * a  / PROCESSCOUNT;
    if (b && c > 0) {
        width += 1.0 * b / c / PROCESSCOUNT;
    }
    return width;
}

#pragma mark -
#pragma mark IDPModelObserver methods

- (void)modelDidLoad:(id)theModel {
    if (theModel == self.postImageContext) {
        self.token = self.postImageContext.token;
        self.status = processorStatusImageSendingComplete;
        [self getDescriptionWithToken:self.postImageContext.token];
        [TAGMANAGER sendCamFindPost];
    }
    if (theModel == self.getDescriptionContext) {
        if (self.getDescriptionContext.imageDescription) {
            self.imageDescription = self.getDescriptionContext.imageDescription;
            self.status = processorStatusDescriptionGettingComplete;
            [self searchImpctfulForDescription:self.getDescriptionContext.imageDescription];
            [TAGMANAGER sendCamFindDescription:self.imageDescription];
        } else {
            [self startDescriptionGetting];
        }
    }
    if (theModel == self.getSearchContext) {
        self.xmlData = self.getSearchContext.xmlData;
        self.status = processorStatusImpctfulSearchingComplete;
        [self processXML:self.getSearchContext.xmlData];
        [TAGMANAGER sendImpctfulSearch:self.getSearchContext.searchString];
        if (!self.result.count) {
            [TAGMANAGER sendEmptyImpctfulSearch:self.getSearchContext.searchString];
        }
    }
}

- (void)modelDidFailToLoad:(id)theModel {
    if (theModel == self.postImageContext) {
        self.status = processorStatusImageSendingFailed;
    }
    if (theModel == self.getDescriptionContext) {
        self.status = processorStatusDescriptionGettingFailed;
    }
    if (theModel == self.getSearchContext) {
        self.status = processorStatusImpctfulSearchingFailed;
    }
    [self failLoading];
}

@end
