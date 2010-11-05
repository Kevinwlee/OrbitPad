//
//  GravityPoint.m
//  OrbitPad
//
//  Created by Kevin Lee on 10/26/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "GravityPoint.h"


@implementation GravityPoint
@synthesize mass, thrustMagnitude, draggable, angle, velocity;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		draggable = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//	CGContextRef context =  UIGraphicsGetCurrentContext();
//	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
//	
//	CGContextMoveToPoint(context, self.bounds.origin.x + self.frame.size.width /2, 5);
//	CGContextAddLineToPoint(context, self.bounds.origin.x + self.frame.size.width /2, self.frame.size.height-5);
//	CGContextAddEllipseInRect(context, CGRectMake(self.bounds.origin.x + 5, self.bounds.origin.y +5, self.frame.size.width - 10, self.frame.size.height-10));
//	// And width 2.0 so they are a bit more visible
//	CGContextSetLineWidth(context, 2.0);
//	CGContextStrokePath(context);
}


- (void)setAngle:(CGFloat)a {
	if (a <0) {
		angle = 360 -a;
	}else {
		angle = a;
	}

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"began");
	if (!draggable) {
		[super touchesBegan:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (draggable) {
		UITouch *t = [touches anyObject];
		self.center = [t locationInView:[self superview]];
	}
	else {
		[super touchesMoved:touches withEvent:event];
	}

}

- (void)dealloc {
    [super dealloc];
}

@end
