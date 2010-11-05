//
//  PurpleGlowStar.m
//  OrbitPad
//
//  Created by Kevin Lee on 10/29/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "PurpleGlowStar.h"


@implementation PurpleGlowStar


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
		CGFloat colors[] =
		{
			204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
			128.0 / 255, 0.0 / 255.0, 128.0 / 255, 1.00,
			128 / 255, 0.0 / 255.0, 128.0 / 255, 0.00,
			
		};
		gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
		CGColorSpaceRelease(rgb);
		
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
