//
//  UIView+Hud.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "UIView+Hud.h"
#import <WSProgressHUD/WSProgressHUD.h>

@implementation UIView (Hud)

- (void)showHudWithText:(NSString *)text
{
    [WSProgressHUD showShimmeringString:text];
}

- (void)hideHud
{
    [WSProgressHUD dismiss];
}

- (UIAlertView *)showTipAlertWithContent:(NSString *)content
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    return alert;
}

- (void)showStatus:(NSString *)status{

    [WSProgressHUD showWithStatus:status];
}

- (void)showProgress:(CGFloat)progress status:(NSString *)status{

    [WSProgressHUD showProgress:progress status:status];
    
    if(progress < 1.0f)
    {

    } else {
        
        [WSProgressHUD showImage:nil status:@"上传成功"];
        progress = 0;
    }


}
@end
