//
//  AppDelegate.h
//  VideoCamera
//
//  Created by Aditya Narayan on 4/21/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navControl;
@property (strong, nonatomic) ViewController *viewController;

@end

