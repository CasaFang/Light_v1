//
//  LightValidateCodeViewController.h
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"

@interface LightValidateCodeViewController : UIViewController

@property (strong , nonatomic) LightUser *user;

@property (assign , nonatomic) int checkType;

@end
