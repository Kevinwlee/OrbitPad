//
//  algebra.m
//  ball
//
//  Created by Kevin Lee on 10/23/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "Math.h"


@implementation Math

+ (CGFloat)distance:(CGPoint)point1 point2:(CGPoint)point2 {
	return sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2));
}
+ (CGFloat)slope:(CGPoint)point1 point2:(CGPoint)point2 {
	return (point2.y - point1.y)/(point2.x - point1.x);
}
+ (CGFloat)intercept:(CGPoint)point slope:(CGFloat)slope {
	return point.y - (slope * point.x);
}
+ (CGFloat)yWithX:(CGFloat)x andSlope:(CGFloat)slope andIntercept:(CGFloat)intercept {
	return slope * x +intercept;
}
+ (CGFloat)offsetX:(CGFloat)angle radius:(CGFloat)radius {	
	CGFloat pi = 3.14;
	return cosf(angle / 180 * pi) * radius;
}
+ (CGFloat)offsetY:(CGFloat)angle radius:(CGFloat)radius{
	CGFloat pi = 3.14;
	return sinf(angle / 180 * pi) * radius;
}
@end
