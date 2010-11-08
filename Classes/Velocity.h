//
//  velocity.h
//  OrbitPad
//
//  Created by Kevin Lee on 11/5/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Velocity : UIView {
	CGPoint _point;
}

- (void) drawVelocityVectorForVelocity:(CGPoint)point;
@end
