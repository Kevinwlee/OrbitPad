//
//  untitled.m
//  OrbitPad
//
//  Created by Kevin Lee on 10/29/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "GlowStar.h"


@implementation GlowStar


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
		CGFloat colors[] =
		{
			204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
			0.00 / 255.0, 255.0 / 255.0, 0.0 / 255.0, 1.00,
			29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 0.00,
		};
		gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
		CGColorSpaceRelease(rgb);
		//29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
		//227 / 255.0, 35 / 255.0, 84 / 255.0, 1.00,
		//0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 0,
//		29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
//		29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 0.00,
    }
    return self;
}

CGPoint demoRGCenter(CGRect bounds)
{
	return CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}

// Returns an appropriate inner radius for the demonstration of the radial gradient
CGFloat demoRGInnerRadius(CGRect bounds)
{
	CGFloat r = bounds.size.width < bounds.size.height ? bounds.size.width : bounds.size.height;
	return r * 0.125;
}

// Returns an appropriate outer radius for the demonstration of the radial gradient
CGFloat demoRGOuterRadius(CGRect bounds)
{
	CGFloat r = bounds.size.width < bounds.size.height ? bounds.size.width : bounds.size.height;
	return r * .5;
}



- (void)drawRect:(CGRect)rect {
	
	CGContextRef context =  UIGraphicsGetCurrentContext();
	CGRect clip = CGRectInset(CGContextGetClipBoundingBox(context), 0, 0);
	
	CGPoint start, end;
	CGFloat startRadius, endRadius;
	
	CGContextSaveGState(context);
	CGContextClipToRect(context, clip);
	CGGradientDrawingOptions options = 0;
	options |= kCGGradientDrawsBeforeStartLocation;

	start = end = demoRGCenter(clip);
	startRadius = demoRGInnerRadius(clip);
	endRadius = demoRGOuterRadius(clip);
	CGContextDrawRadialGradient(context, gradient, start, startRadius, end, endRadius, options);
	CGContextRestoreGState(context);
	
	
}


- (void)dealloc {
    [super dealloc];
}


@end
