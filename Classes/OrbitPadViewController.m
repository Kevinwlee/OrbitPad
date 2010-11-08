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
	triangles = [[NSMutableDictionary dictionary] retain];
	
	Triangle *t1 = [[Triangle alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:t1];
	[triangles setValue:t1 forKey:@"green"];
	[t1 release];
	
	Triangle *t2 = [[Triangle alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:t2];
	[triangles setValue:t2 forKey:@"red"];
	[t2 release];
	
	Triangle *t3 = [[Triangle alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:t3];
	[triangles setValue:t3 forKey:@"blue"];
	[t3 release];
	
	
	stars = [[NSMutableArray array] retain];
	
	greenRect = [[GlowStar alloc] initWithFrame:CGRectMake(10, 10, 120, 120)];
	greenRect.backgroundColor = [UIColor clearColor];
	greenRect.mass = 40;
	greenRect.key = @"green";
	[self.view addSubview:greenRect];
	[stars addObject:greenRect];
	[greenRect release];
	
	blueRect = [[BlueGlowStar alloc] initWithFrame:CGRectMake(100, 0, 80, 80)];
	blueRect.backgroundColor = [UIColor clearColor];
	blueRect.mass = 30;
	blueRect.key = @"blue";
	[stars addObject:blueRect];
	[self.view addSubview:blueRect];
	[blueRect release];
		
	redRect = [[RedGlowStar alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2, self.view.frame.size.width/2, 80, 80)];
	redRect.backgroundColor = [UIColor clearColor];
	redRect.mass = 30;
	redRect.key = @"red";
	[stars addObject:redRect];
	[self.view addSubview:redRect];
	[redRect release];
	

	ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ship.png"]];
	bouncingRect = [[GravityPoint alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 -20, self.view.frame.size.height/2 -20, 30,30)];
	bouncingRect.backgroundColor = [UIColor clearColor];
	bouncingRect.mass = 10;
	bouncingRect.angle = 90;
	bouncingRect.draggable = NO;
	bouncingRect.velocity = CGPointMake(0, 0);
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
		CGPoint newv = CGPointMake(bouncingRect.velocity.x *-1, bouncingRect.velocity.y);
		bouncingRect.velocity = newv;
	}
	
	//Top Wall
	if (newPoint.y < 0) {
		newPoint.y = 0;
		CGPoint newv = CGPointMake(bouncingRect.velocity.x , bouncingRect.velocity.y*-1);
		bouncingRect.velocity = newv;	}
	
	//Right Wall
	if (newPoint.x > self.view.bounds.size.width - bouncingRect.frame.size.width) {
		newPoint.x = self.view.bounds.size.width - bouncingRect.frame.size.width;
		CGPoint newv = CGPointMake(bouncingRect.velocity.x *-1, bouncingRect.velocity.y);
		bouncingRect.velocity = newv;

	}
	
	//Bottom Wall
	if (newPoint.y > self.view.bounds.size.height - bouncingRect.frame.size.height) {
		newPoint.y = self.view.bounds.size.height - bouncingRect.frame.size.height;
		CGPoint newv = CGPointMake(bouncingRect.velocity.x , bouncingRect.velocity.y*-1);
		bouncingRect.velocity = newv;	
	}
	
	bouncingRect.center = newPoint;
	
}

- (void)draw{		
	CGFloat xOffset = 0;
	CGFloat yOffset = 0;
	for (id *star in stars) {
		GravityPoint *g = (GravityPoint*)star;
		
		if ([Math distance:bouncingRect.center point2:g.center] < 600){
			
			CGFloat bx = bouncingRect.center.x - g.center.x ;
			CGFloat ay = bouncingRect.center.y - g.center.y;
			CGFloat distx = pow(bx, 2);
			CGFloat disty = pow(ay, 2);
			if (distx +disty == 0) {
				distx = .001;
				disty = .001;
			}
			CGFloat dist = sqrt((distx + disty));
			if (dist == 0)
				dist = 1;
			
			//bouncingRect.thrustMagnitude += (1/dist) *g.mass;
			CGFloat forceA = (fabs(ay) / pow(dist,2) * g.mass);
			CGFloat forceB = fabs(bx) /pow(dist,2) *g.mass;
			if (ay > 0)
				forceA *=-1;
			if (bx > 0) {
				forceB *=-1;
			}
			//offsets
			xOffset += (forceB );
			yOffset += (forceA );
			NSLog(@"CurentHeading:%g", bouncingRect.angle);
			
			//Draws the triangle 
			Triangle *t = [triangles objectForKey:g.key];
			if (t) {
				[t triangulate:bouncingRect.center withAStar:g.center];
			}
		}
	}
	bouncingRect.velocity = CGPointMake(bouncingRect.velocity.x + xOffset, bouncingRect.velocity.y + yOffset);
	CGPoint newCenter = CGPointMake(bouncingRect.center.x + bouncingRect.velocity.x, bouncingRect.center.y + bouncingRect.velocity.y);

	
	//CGFloat ftangle = atan2( newCenter.y, newCenter.x );
	[self setCurrentPoint:newCenter];
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
