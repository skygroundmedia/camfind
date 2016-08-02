//
//  UIViewController+IDPExtensions.h
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDPViewControllerViewOfClassGetterSynthesize(theClass, getterName) \
        - (theClass *)getterName { \
            if ([self.view isKindOfClass:[theClass class]]) { \
                return (theClass *)self.view; \
            } \
            return nil; \
        }

@interface UIViewController (IDPExtensions)

@property (nonatomic, retain, readonly) UITableView *tableView;

+ (id)defaultNibController;

@end
