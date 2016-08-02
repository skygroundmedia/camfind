//
//  CGGeometry+RSLAdditions.m
//  BudgetJar
//
//  Created by Oleksa Korin on 5/21/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "CGGeometry+IDPExtensions.h"

NSComparisonResult CGPointCompareToPoint(CGPoint src, CGPoint dst) {
	NSComparisonResult result = (CGPointCompareToPointByY(src, dst));
	
	if (result != NSOrderedSame) {
		return result;
	}
	
	return CGPointCompareToPointByX(src, dst);
}

NSComparisonResult CGPointCompareToPointByX(CGPoint src, CGPoint dst) {
	if (src.x < dst.x) {
		return NSOrderedAscending;
	} else if (src.x > dst.x) {
		return NSOrderedDescending;
	}
	
	return NSOrderedSame;
}

NSComparisonResult CGPointCompareToPointByY(CGPoint src, CGPoint dst) {
	if (src.y < dst.y) {
		return NSOrderedAscending;
	} else if (src.y > dst.y) {
		return NSOrderedDescending;
	}
	
	return NSOrderedSame;
}