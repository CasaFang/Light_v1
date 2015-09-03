//
//  LightRegViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightRegViewController.h"
#import "LightRegPhoneViewController.h"
#import "LightValidateCodeViewController.h"
#import "UIView+Hud.h"
#import "LightUser+Register.h"
#import "LightServerContactViewController.h"

@interface LightRegViewController ()


@property (weak , nonatomic) IBOutlet UITextField *codeTextField;

- (IBAction)onNext:(id)sender;
- (IBAction)onPhoneRegister:(id)sender;
- (IBAction)onServiceContract:(id)sender;
- (IBAction)onLogin:(id)sender;
- (IBAction)onBack:(id)sender;

@end

@implementation LightRegViewController
@synthesize user;

#pragma make lifeCycle
- (void)viewDidLoad {
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


#pragma mark -- actions
- (void)onNext:(id)sender{
    
    [self.view endEditing:YES];
    
    [self.view showHudWithText:@"请求验证码..."];
    __weak typeof(self)  weakSelf = self;
    
    [user registerWithEmailCode:_codeTextField.text andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            LightValidateCodeViewController *validateViewController = [[LightValidateCodeViewController alloc]initWithNibName:@"LightValidateCodeViewController" bundle:nil];
            validateViewController.user = weakSelf.user;
            validateViewController.checkType = 1;
            [weakSelf.navigationController pushViewController:validateViewController animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
    
}
- (void)onPhoneRegister:(id)sender{

    LightRegPhoneViewController *phoneReqViewController = [[LightRegPhoneViewController alloc]initWithNibName:@"LightRegPhoneViewController" bundle:nil];
    phoneReqViewController.user = user;
    [self.navigationController pushViewController:phoneReqViewController animated:YES];
}
-(void)onServiceContract:(id)sender{

    LightServerContactViewController *c = [LightServerContactViewController new];
    [self.navigationController pushViewController:c  animated:YES];
}
-(void)onLogin:(id)sender{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
