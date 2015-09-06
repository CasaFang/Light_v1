//
//  LightRegUserInfoViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightRegUserInfoViewController.h"
#import "LightRegSexViewController.h"
#import "LightUser+Register.h"
#import "LightUser.h"
#import "UIView+Hud.h"
#import "NSString+Extention.h"
#import "AppDelegate.h"

@interface LightRegUserInfoViewController ()


@property (weak , nonatomic) IBOutlet UITextField *nameTextField;
@property (weak , nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak , nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)onNext:(id)sender;
- (IBAction)onBack:(id)sender;
- (IBAction)onSeePwd:(UIButton *)sender;

@end

@implementation LightRegUserInfoViewController
@synthesize user;

#pragma make lifeCycle
- (void)viewDidLoad {
    _passwordTextField.secureTextEntry = YES;
    _confirmPasswordTextField.secureTextEntry = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark   actions

- (void)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onNext:(id)sender{

    [self.view endEditing:YES];
    [self.view showHudWithText:@"正在注册用户信息..."];
    __weak typeof(self)  weakSelf = self;

    user.name = [_nameTextField.text trimWhiteSpace];
    user.password = [_passwordTextField.text trimWhiteSpace];
    NSString *confirmPwd = [_confirmPasswordTextField.text trimWhiteSpace];
    
    if (user.password.length <6) {
        
        [self.view showTipAlertWithContent:@"密码长度不够"];
        return;
    }
    
    if (![confirmPwd isEqualToString:user.password]) {
        
        [self.view showTipAlertWithContent:@"俩次密码不一样"];
        return;
    }
    
    /**
    LightRegSexViewController *c = [[LightRegSexViewController alloc]initWithNibName:@"LightRegSexViewController" bundle:nil];
    c.user = user;
    
    [self.navigationController pushViewController:c animated:YES];
     **/
    
    //跳过设定性别的环节
    
    [user addRegisterWithPassword:user.password andName:user.name andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate toLogin];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
}
- (void)onSeePwd:(UIButton *)sender
{
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    sender.selected = !sender.selected;
}

@end
