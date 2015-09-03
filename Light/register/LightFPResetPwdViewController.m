//
//  LightForgotPwdPwdViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightFPResetPwdViewController.h"
#import "LightTextField.h"
#import "NSString+Extention.h"
#import "UIView+Hud.h"


@interface LightFPResetPwdViewController ()

@property (weak , nonatomic) IBOutlet LightTextField *pwdTextField;
@property (weak , nonatomic) IBOutlet LightTextField *pwdConfirmTextField;

- (IBAction)onNext:(id)sender;
- (IBAction)onCancle:(id)sender;

@end

@implementation LightFPResetPwdViewController
@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super  viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onNext:(id)sender{
    
    [self.view endEditing:YES];
    
    NSString *pwd1 = [_pwdTextField.text trimWhiteSpace];
    NSString *pwd2 = [_pwdConfirmTextField.text trimWhiteSpace];
    
    if (pwd1.length <6 || pwd2.length <6) {
        
        [self.view showTipAlertWithContent:@"密码长度至少6位"];
    }
    else if (![pwd2 isEqualToString:pwd1]){
    
        [self.view showTipAlertWithContent:@"俩次密码输入不一致"];
    }
    else
    {
        __weak typeof(self) weakSelf = self;
        
        [self.view showHudWithText:@"正在修改密码..."];
        
        [user changePwdWithNewPwd:pwd1 andBlock:^(BOOL isSuccess, NSError *error) {
            
            [weakSelf.view hideHud];
            
            if (isSuccess) {
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                
                [weakSelf.view showTipAlertWithContent:error.domain];
            }
        }];
    }
    
}
- (void)onCancle:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
