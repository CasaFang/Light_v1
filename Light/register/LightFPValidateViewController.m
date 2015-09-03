//
//  LightForgotPwdValidateViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightFPValidateViewController.h"
#import "LightTextField.h"
#import "LightFPResetPwdViewController.h"
#import "UIView+Hud.h"

@interface LightFPValidateViewController ()

@property (weak , nonatomic) IBOutlet LightTextField *validateTextField;


- (IBAction)onNext:(id)sender;
- (IBAction)onCancle:(id)sender;

@end

@implementation LightFPValidateViewController
@synthesize user;
@synthesize checkType;

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

- (void)onNext:(id)sender
{
    [self.view endEditing:YES];
    [self.view showHudWithText:@"正在校验..."];
    __weak typeof(self) weakSelf  = self;
    
    [user fpValidateCode:_validateTextField.text checkType:checkType andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
       
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            LightFPResetPwdViewController *c = [[LightFPResetPwdViewController alloc]initWithNibName:@"LightFPResetPwdViewController" bundle:nil];
            c.user = weakSelf.user;
            [weakSelf.navigationController pushViewController:c animated:YES];
        }
        else
        {
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];
    
   
}
- (void)onCancle:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
