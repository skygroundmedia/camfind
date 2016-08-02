//
//  IDPPropertyMacros.h
//  PatternShots
//
//  Created by Oleksa 'trimm' Korin on 2/20/13.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#define IDPNonatomicRetainPropertySynthesize(ivar, newObj) do{if(ivar!=newObj){[ivar release];ivar=[newObj retain];}}while(0)
#define IDPNonatomicCopyPropertySynthesize(ivar, newObj) do{if(ivar!=newObj){[ivar release];ivar=[newObj copy];}}while(0)
#define IDPNonatomicAssignPropertySynthesize(ivar, newObj) do{ivar=newObj;}while(0)


