//
//  LightValidateCodeViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightValidateCodeViewController.h"
#import "LightRegUserInfoViewController.h"
#import "UIView+Hud.h"
#import "LightUser+Register.h"

@interface LightValidateCodeViewController ()

@property (weak , nonatomic) IBOutlet UITextField *codeTextField;

- (IBAction)onNext:(id)sender;
- (IBAction)onBack:(id)sender;

@end

@implementation LightValidateCodeViewController
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


#pragma mark  actions

- (void)onNext:(id)sender
{
    [self.view endEditing:YES];
    
    [self.view showHudWithText:@"正在验证..."];
    __weak typeof(self)  weakSelf = self;
    
    [user validateCodeWithCode:_codeTextField.text checkType:_checkType andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            LightRegUserInfoViewController *userInfoC = [[LightRegUserInfoViewController alloc]initWithNibName:@"LightRegUserInfoViewController" bundle:nil];
            userInfoC.user = weakSelf.user;
            
            [weakSelf.navigationController pushViewController:userInfoC animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
    
   
}
- (void)onBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
