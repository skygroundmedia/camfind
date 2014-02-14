//
//  CFMainProcessor.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 2/5/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

typedef enum {
    processorStatusReady,
    processorStatusImageSending,
    processorStatusImageSendingComplete,
    processorStatusImageSendingFailed,
    processorStatusDescriptionGetting,
    processorStatusDescriptionGettingComplete,
    processorStatusDescriptionGettingFailed,
    processorStatusImpctfulSearching,
    processorStatusImpctfulSearchingComplete,
    processorStatusImpctfulSearchingFailed,
    processorStatusComplete,
} processorStatus;

#define PROCESSCOUNT 3.0

@interface CFMainProcessor : IDPModel

@property (nonatomic, readonly) UIImage         *image;
@property (nonatomic, readonly) NSString        *token;
@property (nonatomic, readonly) NSString        *imageDescription;
@property (nonatomic, readonly) NSArray         *result;
@property (nonatomic, readonly) processorStatus status;
@property (nonatomic, readonly) int             getDescriptionRepeatCounter;

+ (NSArray *)statusStrings;
+ (void)saveImageToAlbum:(UIImage *)image;

- (void)sendImage:(UIImage *)image;
- (void)getDescriptionWithToken:(NSString *)token;
- (void)searchImpctfulForDescription:(NSString *)imageDescription;

- (float)indicatorWidth;// 0 ... 1.0

@end
