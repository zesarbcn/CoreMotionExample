//
//  ViewController.m
//  CoreMotionExample
//
//  Created by Cesar Perez Laguna on 19/09/14.
//  Copyright (c) 2014 Cesar Perez Laguna. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    CATransformLayer *container;
}

@end

@implementation ViewController

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Create scene
    [self createMyScene];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self startMyMotionDetect];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self.motionManager stopDeviceMotionUpdates];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startMyMotionDetect
{
    if (self.motionManager.isDeviceMotionAvailable) {
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
            
            double yaw = self.motionManager.deviceMotion.attitude.yaw;
            double pitch = self.motionManager.deviceMotion.attitude.pitch;
            double roll = self.motionManager.deviceMotion.attitude.roll;
            //NSLog(@"yaw: %f -- pitch: %f -- roll: %f", yaw,pitch,roll);
            
            CATransform3D transform;
            transform = CATransform3DMakeRotation(pitch, 1, 0, 0);      // pitch - X
            transform = CATransform3DRotate(transform, roll, 0, 1, 0);  // roll  - Y
            transform = CATransform3DRotate(transform, yaw, 0, 0, 1);   // yaw   - Z
            
            container.transform = transform;
        }];
    }
}

-(void)createMyScene
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    container = [CATransformLayer layer];
    container.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    [self.view.layer addSublayer:container];
    
    CGPoint sqPosition = CGPointMake(screenRect.size.width/2, screenRect.size.height/2);
    CGSize sqSize = CGSizeMake(100, 100);
    
    // Squares
    CALayer *purpleSquare = [self addSquareToLayer:container
                                              size:sqSize
                                          position:sqPosition
                                             color:[UIColor purpleColor]];
    CALayer *redSquare = [self addSquareToLayer:container
                                           size:sqSize
                                       position:sqPosition
                                          color:[UIColor redColor]];
    CALayer *orangeSquare = [self addSquareToLayer:container
                                              size:sqSize
                                          position:sqPosition
                                             color:[UIColor orangeColor]];
    CALayer *yellowSquare = [self addSquareToLayer:container
                                              size:sqSize
                                          position:sqPosition
                                             color:[UIColor yellowColor]];
    
    
    [CATransaction setDisableActions:YES];
    
    // Transformations
    CATransform3D t = CATransform3DIdentity;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, 0);
    purpleSquare.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -40);
    redSquare.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -80);
    orangeSquare.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -120);
    yellowSquare.transform = t;
    
}



-(CALayer*)addSquareToLayer:(CALayer*)parent size:(CGSize)size position:(CGPoint)point color:(UIColor*)color
{
    CALayer *square = [CALayer layer];
    
    square.frame = CGRectMake(0, 0, size.width, size.height);
    square.position = point;
    //square.anchorPoint = CGPointMake(0.5, 0.5);
    square.opacity = 0.6;
    square.backgroundColor = [color CGColor];
    square.borderColor = [[UIColor colorWithWhite:1.0 alpha:0.5]CGColor];
    square.borderWidth = 3;
    square.cornerRadius = 10;
    square.shadowColor = [[UIColor blackColor] CGColor];
    square.shadowOffset= CGSizeMake(5.0f, 5.0f);
    square.shadowOpacity=0.5f;
    square.shadowRadius = 2.0f;
    
    [parent addSublayer:square];
    
    return square;
}

@end
