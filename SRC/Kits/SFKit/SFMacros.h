//
//  GRMacros.h
//  Gurmendo
//
//  Created by Alexandr Chernov on 10/15/13.
//  Copyright (c) 2013 IDAP. All rights reserved.
//

#define IDPNonatomicRetainModelSynthesizeWithObserving(ivar, newObj, observer) \
do{if(ivar!=newObj){[ivar removeObserver:observer];[ivar release];ivar=[newObj retain];[ivar addObserver:observer];}}while(0)

#define IDPViewControllerViewOfClassGetterSynthesize(theClass, getterName) \
- (theClass *)getterName { \
if ([self.view isKindOfClass:[theClass class]]) { \
return (theClass *)self.view; \
} \
return nil; \
}
