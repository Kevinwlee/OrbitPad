//
//  OrbitPadViewController.m
//  OrbitPad
//
//  Created by Kevin Lee on 10/23/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import "OrbitPadViewController.h"
#import "Math.h"
#import "BlueGlowStar.h"
#import "GreenGlowStar.h"
#import "RedGlowStar.h"
#import "PurpleGlowStar.h"

#define kTimestep 0.035
@implementation OrbitPadViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	triangle = [[Triangle alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:triangle];
	[triangle release];
	
	stars = [[NSMutableArray array] retain];
	
	greenRect = [[GlowStar alloc] initWithFrame:CGRectMake(10, 10, 120, 120)];
	greenRect.backgroundColor = [UIColor clearColor];
	greenRect.mass = 90;
	[self.view addSubview:greenRect];
	[stars addObject:greenRect];
	[greenRect release];
	
//	blueRect = [[BlueGlowStar alloc] initWithFrame:CGRectMake(100, 0, 80, 80)];
//	blueRect.backgroundColor = [UIColor clearColor];
//	blueRect.mass = 30;
//	[stars addObject:blueRect];
//	[self.view addSubview:blueRect];
//	[blueRect release];
//		
//	redRect = [[RedGlowStar alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2, self.view.frame.size.width/2, 80, 80)];
//	redRect.backgroundColor = [UIColor clearColor];
//	redRect.mass = 30;
//	[stars addObject:redRect];
//	[self.view addSubview:redRect];
//	[redRect release];
	

	ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ship.png"]];
	bouncingRect = [[GravityPoint alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 -20, self.view.frame.size.height/2 -20, 30,30)];
	bouncingRect.backgroundColor = [UIColor clearColor];
	bouncingRect.mass = 10;
	bouncingRect.thrustMagnitude = 100 ;
	bouncingRect.angle = 100;
	bouncingRect.draggable = NO;
	[bouncingRect addSubview:ship];
	[ship release];
	[self.view addSubview:bouncingRect];
	
	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *t = [touches anyObject];	
	if ([t tapCount] == 1) {
		if (!timer) {
			timer = [[NSTimer scheduledTimerWithTimeInterval:kTimestep target:self selector:@selector(draw) userInfo:nil repeats:YES] retain];
			if (lastDrawTime ==nil) {
				lastDrawTime = [[NSDate alloc] init];
			}

		}
	}
	
	if ([t tapCount] == 2) {
		[timer invalidate];
		timer = nil;
		lastDrawTime = nil;
	}
	
	if ([t tapCount] ==3) {
		CGPoint touchPoint = [t locationInView:self.view];
		PurpleGlowStar *tripple = [[PurpleGlowStar alloc] initWithFrame:CGRectMake(touchPoint.x,touchPoint.y, 60, 60)];
		tripple.backgroundColor = [UIColor clearColor];
		tripple.mass = 10;
		[stars addObject:tripple];
		[self.view addSubview:tripple];
		[tripple release];
	}
}

- (void)setCurrentPoint:(CGPoint)newPoint {
	
	//Left Wall
	if (newPoint.x < 0 + bouncingRect.frame.size.width/2) {
		newPoint.x = 0 + bouncingRect.frame.size.width/2;
		NSLog(@"Left Before");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
		CGFloat deflectionAngle = 0;
		if (bouncingRect.angle > 180) {
			deflectionAngle = 270 + (180 - (90 + (bouncingRect.angle - 180)));
		}else {
			deflectionAngle = 180- bouncingRect.angle;			
		}
		bouncingRect.angle = fmod(deflectionAngle, 360.0f);
		NSLog(@"Left Wall");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
	}
	
	//Top Wall
	if (newPoint.y < 0) {
		newPoint.y = 0;
		NSLog(@"Top Before");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
		CGFloat deflectionAngle = 180 - (bouncingRect.angle - 180);		
		bouncingRect.angle = fmod(( deflectionAngle), 360.0f);
		NSLog(@"Top After");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
	}
	
	//Right Wall
	if (newPoint.x > self.view.bounds.size.width - bouncingRect.frame.size.width) {
		newPoint.x = self.view.bounds.size.width - bouncingRect.frame.size.width;
		CGFloat deflectionAngle = 0;
		if (bouncingRect.angle > 180) {
			deflectionAngle = 180 + (360 - bouncingRect.angle);
		}else {
			deflectionAngle = 180 - (2* bouncingRect.angle);			
		}

		
		bouncingRect.angle = fmod( deflectionAngle, 360.0f);
		NSLog(@"Right Wall");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
	}
	
	//Bottom Wall
	if (newPoint.y > self.view.bounds.size.height - bouncingRect.frame.size.height) {
		newPoint.y = self.view.bounds.size.height - bouncingRect.frame.size.height;
		CGFloat deflectionAngle = 360 - (2 * bouncingRect.angle);
		bouncingRect.angle = fmod((bouncingRect.angle + deflectionAngle), 360.0f);
		NSLog(@"Bottom Wall");
		NSLog(@"x: %g, y: %g, a: %g", newPoint.x, newPoint.y, bouncingRect.angle);
	}
	//bouncingRect.angle = atan2( newPoint.y, newPoint.x )* 180 / M_PI;
	ship.transform = CGAffineTransformMakeRotation(bouncingRect.angle * M_PI/180); //* M_PI/180  +1.57
	bouncingRect.center = newPoint;
}

- (void)draw{
	//static NSDate *lastDrawTime;
	if (lastDrawTime){
		NSTimeInterval secondsSinceLastDraw = -([lastDrawTime timeIntervalSinceNow]);
		CGFloat xOffset = 0;
		CGFloat yOffset = 0;
		for (id *star in stars) {
			GravityPoint *g = (GravityPoint*)star;
			if ([Math distance:bouncingRect.center point2:g.center] < 300) {				
				CGFloat b = bouncingRect.center.x - g.center.x ;
				CGFloat a = bouncingRect.center.y - g.center.y;
				CGFloat num = pow(b, 2);
				CGFloat den = pow(a, 2);
				CGFloat dist = sqrt(num + den);
				if (dist == 0)
					dist = 1;
				
				//bouncingRect.thrustMagnitude += (1/dist) *g.mass;
				CGFloat forceA = fabs(a / dist);
				CGFloat forceB = fabs(b /dist);
				if (a > 0)
					forceA *=-1;
				if (b > 0) {
					forceB *=-1;
				}
				//offsets
				xOffset += (forceB );
				yOffset += (forceA );
				
				
				NSLog(@"CurentHeading:%g", bouncingRect.angle);
				
				//bouncingRect.angle = fmod((bouncingRect.angle + 3), 360.0f);
				
				//Draws the triangle 
				[triangle triangulate:bouncingRect.center withAStar:g.center];
				
				//bouncingRect.angle += 1;
			}

		}
		
		CGFloat x = [Math offsetX:bouncingRect.angle radius:bouncingRect.thrustMagnitude * secondsSinceLastDraw];
		CGFloat y = [Math offsetY:bouncingRect.angle radius:bouncingRect.thrustMagnitude * secondsSinceLastDraw];
		
		CGPoint newPoint = CGPointMake(bouncingRect.center.x + xOffset +x, bouncingRect.center.y +yOffset +y);
		//CGFloat angleNew = atan2( newPoint.y, newPoint.x )* 180 / M_PI;
		[self setCurrentPoint:newPoint];
	}
	lastDrawTime = [[NSDate alloc] init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	greenRect = nil;
	blueRect = nil;
	yellowRect = nil;
	redRect = nil;	
	bouncingRect = nil;
}

- (void)dealloc {
	[greenRect release];
	[blueRect release];
	[yellowRect release];
	[redRect release];
	[bouncingRect release];
    [super dealloc];
}

@end
