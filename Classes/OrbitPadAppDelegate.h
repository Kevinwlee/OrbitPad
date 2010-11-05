//
//  OrbitPadAppDelegate.h
//  OrbitPad
//
//  Created by Kevin Lee on 10/23/10.
//  Copyright 2010 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrbitPadViewController;

@interface OrbitPadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OrbitPadViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OrbitPadViewController *viewController;

@end

