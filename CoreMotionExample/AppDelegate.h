//
//  AppDelegate.h
//  CoreMotionExample
//
//  Created by Cesar Perez Laguna on 19/09/14.
//  Copyright (c) 2014 Cesar Perez Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) CMMotionManager *motionManager;

@end
