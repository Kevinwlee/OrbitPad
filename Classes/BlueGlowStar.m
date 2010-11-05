//
//  BlueGlowStar.m
//  OrbitPad
//
//  Created by Kevin Lee on 10/29/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "BlueGlowStar.h"


@implementation BlueGlowStar


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
		CGFloat colors[] =
		{
			204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
			29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
			29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 0.00,

		};
		gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
		CGColorSpaceRelease(rgb);
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
