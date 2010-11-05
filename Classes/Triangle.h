//
//  Triangle.h
//  OrbitPad
//
//  Created by Kevin Lee on 11/2/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Triangle : UIView {
	CGPoint ship;
	CGPoint star;
}
-(void)triangulate:(CGPoint)aShip withAStar:(CGPoint)aStar;
@end
