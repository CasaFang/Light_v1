//
//  UIView+Hud.h
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Hud)

- (void)showHudWithText:(NSString *)text;
- (void)hideHud;

- (UIAlertView *)showTipAlertWithContent:(NSString *)content;


- (void)showProgress:(CGFloat)progress status:(NSString *)status;
@end
