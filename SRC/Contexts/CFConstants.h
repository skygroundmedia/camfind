//
//  GRConstants.h
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/27/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#pragma mark -
#pragma mark CamFind

static NSString * const kSFCamFindHost                  = @"https://camfind.p.mashape.com";
static NSString * const kSFCFpostImagePath              = @"image_requests";
static NSString * const kSFCFgetDescriptionPathFormat   = @"image_responses/%@";

static NSString * const kSFCFAuthHeader                 =  @"X-Mashape-Authorization";
static NSString * const kSFCFAuthKey                    =  @"WwvoXA8VZ73TfJafX3nvuKBZ0JaQBtnV";

static NSString * const kSFCFParameterLocale            =  @"image_request[locale]";
static NSString * const kSFCFParameterLocaleKey         =  @"en_US";
static NSString * const kSFCFParameterLanguage          =  @"image_request[language]";
static NSString * const kSFCFParameterLanguageKey       =  @"en";
static NSString * const kSFCFParameterIMage             =  @"image_request[image]";

static NSString * const kSFCFJSONError                  =  @"error";
static NSString * const kSFCFJSONToken                  =  @"token";
static NSString * const kSFCFJSONName                   =  @"name";
static NSString * const kSFCFJSONStatus                 =  @"status";
static NSString * const kSFCFJSONStatusCompleted        =  @"completed";

#pragma mark -
#pragma mark yahoo queries

static NSString * const kSFYahooPath                    =  @"http://query.yahooapis.com/v1/public/yql";
static NSString * const kSFYahooQueryFormat             =  @"SELECT * FROM html WHERE url=\"http://impctful.com/search?x=0&amp;y=0&amp;q=%@\" and xpath='//*[@id=\"search\"]'";
static NSString * const kSFYahooParameterQuery          =  @"q";

#pragma mark -
#pragma mark user defaults keys

static NSString * const kSFDefsTokenKey                 = @"sfKey";
static NSString * const kSFDefsImageDescriptionKey      = @"sfImageDescription";

#pragma mark -
#pragma mark defaults

static NSString * const kSFDefaultDescription           = @"glasses";
static NSString * const kSFDefaultImageName             = @"image.jpg";

static NSString * const kCFNewsURLString                = @"http://mobile.kdfc.com/";
static NSString * const kCFFeedbackURLString            = @"http://mobile.kdfc.com/feedback";

static NSString * const kCFImpctfulHost                 = @"http://impctful.com/";

static double     const kCFMaxImageSize                 = 480.;// if MAX(height, wigth) > maxImageSize then scale = MAX / maxImageSize
static float      const kCFGetDescriptionDelay          = 6.;
static int        const kCFGetDescriptionRepeatCount    = 10;

static NSString * const kCFGetPhotoPrompt               = @"Get photo from";
static NSString * const kCFGetPhotoCancel               = @"Cancel";
static NSString * const kCFGetPhotoFromCamera           = @"Camera";
static NSString * const kCFGetPhotoFromPhotoLibrary     = @"PhotoLibrary";
static NSString * const kCFGetPhotoFromSavedPhotosAlbum = @"SavedPhotosAlbum";

static NSString * const kCFProcessorStatusKey           = @"processorStatus";



