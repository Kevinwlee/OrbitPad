//
//  Triangle.m
//  OrbitPad
//
//  Created by Kevin Lee on 11/2/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "Triangle.h"
#import "Math.h"

@implementation Triangle


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.opaque= NO;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)triangulate:(CGPoint)aShip withAStar:(CGPoint)aStar {
	ship = aShip;
	star = aStar;
	[self setNeedsDisplay];
}

-(void)triangulateAShip:(CGPoint)aShip withAStar:(CGPoint)aStar{
	CGFloat h = [Math distance:aShip point2:aStar];
	CGFloat b = aShip.x - aStar.x ;
	CGFloat a = aShip.y - aStar.y;
	CGFloat A = abs(asinf(a/h)*180/M_PI); //WTF how do i get the angle of A?
	
//	CGRect newFrame = CGRectMake(aShip.x, aStar.y, a*2, b*2);
//	self.frame = newFrame;
	
	CGContextRef context =  UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
	
	// Preserve the current drawing state
	CGContextSaveGState(context);
	
	// Setup the horizontal line to demostrate caps
	CGContextMoveToPoint(context, aShip.x, aShip.y);
	CGContextAddLineToPoint(context, aStar.x, aShip.y);
	CGContextAddLineToPoint(context, aStar.x, aStar.y);
	CGContextAddLineToPoint(context, aShip.x, aShip.y);

	UIColor *mainTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
	[mainTextColor set];
	NSString *aText = [NSString stringWithFormat:@"angle A:%g",A];
	
	[aText drawAtPoint:aShip withFont:[UIFont boldSystemFontOfSize:20]];

	NSString *bText = [NSString stringWithFormat:@"angle B:%g", (90 - A)];
	[bText drawAtPoint:aStar withFont:[UIFont boldSystemFontOfSize:20]];

	NSString *cText = @"angle C: 90";
	[cText drawAtPoint:CGPointMake(aStar.x, aShip.y) withFont:[UIFont boldSystemFontOfSize:20]];

	// Set the line width & cap for the cap demo
	CGContextSetLineWidth(context, 4.0f);	
	//CGContextSetLineCap(context, cap);
	CGContextStrokePath(context);
	
	// Restore the previous drawing state, and save it again.
	CGContextRestoreGState(context);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	[self triangulateAShip:ship withAStar:star];
}


- (void)dealloc {
    [super dealloc];
}


@end
