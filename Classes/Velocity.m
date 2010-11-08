//
//  velocity.m
//  OrbitPad
//
//  Created by Kevin Lee on 11/5/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "Velocity.h"


@implementation Velocity


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		_point = self.center;
    }
    return self;
}
- (void) drawVelocityVectorForVelocity:(CGPoint)point {
	_point = point;
}
- (void)drawRect:(CGRect)rect {

	CGContextRef context =  UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1.0);
	
	// Preserve the current drawing state
	CGContextSaveGState(context);
	
	CGContextMoveToPoint(context, self.center.x  , self.center.y);
	CGContextAddLineToPoint(context, self.center.x + _point.x,self.center.y + _point.y);
	// Set the line width & cap for the cap demo
	CGContextSetLineWidth(context, 4.0f);	
	CGContextStrokePath(context);
	
	// Restore the previous drawing state, and save it again.
	CGContextRestoreGState(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
