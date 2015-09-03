//
//  LightForgotPwsViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightFPCodeViewController.h"
#import "LightTextField.h"
#import "LightFPCodeConfirmViewController.h"
#import "NSString+Extention.h"
#import "UIView+Hud.h"

@interface LightFPCodeViewController ()


@property (weak , nonatomic) IBOutlet LightTextField *codeTextField;

- (IBAction)onConfirm:(id)sender;
- (IBAction)onCancle:(id)sender;

@end

@implementation LightFPCodeViewController



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

#pragma mark -- actions
- (void)onCancle:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)onConfirm:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *code = [_codeTextField.text trimWhiteSpace];
    
    if (code.length == 0) {
        
        [self.view showTipAlertWithContent:@"请填写手机/邮箱"];
    }
    else if ([code isPhoneFormat]||[code isEmailFormat])
    {
        LightFPCodeConfirmViewController *c = [[LightFPCodeConfirmViewController alloc]initWithNibName:@"LightFPCodeConfirmViewController" bundle:nil];
        c.code = code;
        [self.navigationController pushViewController:c animated:YES];
    }
    else{
        
        [self.view showTipAlertWithContent:@"手机/邮箱 格式不正确"];
    }
    
   
}

@end
