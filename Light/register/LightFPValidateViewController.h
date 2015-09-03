//
//  LightForgotPwdValidateViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser+FindPwd.h"

@interface LightFPValidateViewController : UIViewController

@property (strong , nonatomic) LightUser *user;

@property (assign , nonatomic) int checkType;

@end
