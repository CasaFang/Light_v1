//
//  AppDelegate.h
//  Light
//
//  Created by FLY on 15/6/14.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PKRevealController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong , nonatomic) PKRevealController *revealController;

-(void)toMain;
-(void)toLogin;

- (void)showLeftOrCenter;

- (void)resetRevealController;

@end

