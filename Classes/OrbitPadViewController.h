//
//  OrbitPadViewController.h
//  OrbitPad
//
//  Created by Kevin Lee on 10/23/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityPoint.h"
#import "GlowStar.h"
#import "Triangle.h"

@interface OrbitPadViewController : UIViewController {
	NSTimer *timer;
	NSMutableArray *stars;
	GlowStar *greenRect;
	GravityPoint *yellowRect;
	GlowStar *blueRect;
	GlowStar *redRect;
	GravityPoint *purpleRect; 
	GravityPoint *bouncingRect;
	UIImageView *ship;
	NSDate *lastDrawTime;
	Triangle *triangle;
}

@end

