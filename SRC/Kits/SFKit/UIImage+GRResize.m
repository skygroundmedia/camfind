//
//  UIImage+Resize.m
//  Gurmendo
//
//  Created by VladislavChabak on 11/19/13.
//  Copyright (c) 2013 IDAP. All rights reserved.
//

#import "UIImage+GRResize.h"

@implementation UIImage (GRResize)

- (UIImage*)scaledImage:(double)scale {
    CGSize newSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
   
    UIGraphicsBeginImageContext( newSize );
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
