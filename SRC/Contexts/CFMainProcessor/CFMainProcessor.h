//
//  CFMainProcessor.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 2/5/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

typedef enum {
    processorReady,
    processorStatusImageSending,
    processorStatusImageSendingProcessed,
    processorStatusImageSendingFailed,
    processorStatusTokenSending,
    processorStatusTokenSendingProcessed,
    processorStatusTokenSendingFailed,
    processorStatusYQLSending,
    processorStatusYQLSendingProcessed,
    processorStatusYQLSendingFailed,
    processorStatusProcessed,
} processorStatus;

@interface CFMainProcessor : IDPModel

@property (nonatomic, readonly) UIImage         *image;
@property (nonatomic, readonly) NSString        *token;
@property (nonatomic, readonly) NSString        *imageDescription;
@property (nonatomic, readonly) NSArray         *result;
@property (nonatomic, readonly) processorStatus status;
@property (nonatomic, readonly) int             getDescriptionRepeatCounter;

+ (NSString *)stringForStatus:(processorStatus)status;
+ (void)saveImageToAlbum:(UIImage *)image;

- (void)processingImage:(UIImage *)image;
- (void)processingToken:(NSString *)token;
- (void)processingDescription:(NSString *)imageDescription;

@end
