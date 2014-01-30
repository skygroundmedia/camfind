//
//  CGGeometry+IDPExtensions.h
//  BudgetJar
//
//  Created by Oleksa Korin on 5/21/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#define CGWidth(rect) CGRectGetWidth(rect)
#define CGHeight(rect) CGRectGetHeight(rect)
#define CGMaxX(rect) CGRectGetMaxX(rect)
#define CGMaxY(rect) CGRectGetMaxY(rect)
#define CGMidX(rect) CGRectGetMidX(rect)
#define CGMidY(rect) CGRectGetMidY(rect)
#define CGMinX(rect) CGRectGetMinX(rect)
#define CGMinY(rect) CGRectGetMinY(rect)

CG_INLINE
CGRect CGRectWithSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

CG_INLINE 
CGRect CGZeroOriginRectWithRect(CGRect rect) {
	return CGRectMake(0, 0, CGWidth(rect), CGHeight(rect));
}

CG_INLINE
CGFloat CGFloatMakeEven(CGFloat value) {
	NSInteger intValue = (NSInteger)roundf(value);
	if (intValue % 2 != 0) {
		intValue -= 1;
	}
	
	return (CGFloat)intValue;
}

CG_INLINE
BOOL CGFloatInRange(CGFloat value, CGFloat minBound, CGFloat maxBound) {
    return value >= minBound && value <= maxBound;
}

CG_INLINE
BOOL CGFloatEqualToFloatWithTolerance(CGFloat value1, CGFloat value2, CGFloat tolerance) {
    return ABS(value1 - value2) <= tolerance;
}

CG_INLINE
CGFloat CGDistance(CGPoint point1, CGPoint point2) {
    float dx = point1.x - point2.x;
    float dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

CG_EXTERN
NSComparisonResult CGPointCompareToPoint(CGPoint src, CGPoint dst);

CG_EXTERN
NSComparisonResult CGPointCompareToPointByX(CGPoint src, CGPoint dst);

CG_EXTERN
NSComparisonResult CGPointCompareToPointByY(CGPoint src, CGPoint dst);
