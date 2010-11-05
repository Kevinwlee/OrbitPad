//
//  GravityPoint.h
//  OrbitPad
//
//  Created by Kevin Lee on 10/26/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GravityPoint : UIView {
	BOOL draggable;

}

@property (nonatomic) NSInteger mass;
@property (nonatomic) CGFloat thrustMagnitude;
@property (nonatomic) CGFloat angle;
@property (nonatomic) BOOL draggable;
@property (nonatomic) CGPoint velocity;
@end
