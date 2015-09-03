//
//  LightLoginNewViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightLoginNewViewController.h"
#import "LightRegViewController.h"
#import "LightUser.h"
#import "LightTextField.h"
#import "UIView+Hud.h"
#import "AppDelegate.h"
#import "LightUser+Login.h"
#import "LightFPCodeViewController.h"

@interface LightLoginNewViewController ()

@property (weak , nonatomic) IBOutlet UIImageView    *bgImageView;
@property (weak , nonatomic) IBOutlet LightTextField *nameTextField;
@property (weak , nonatomic) IBOutlet LightTextField *passwordTextField;

@property (strong , nonatomic) LightUser *user;


- (IBAction)onForgotPasswrod:(id)sender;
- (IBAction)onLogin:(id)sender;
- (IBAction)onRegister:(id)sender;

@end

@implementation LightLoginNewViewController
@synthesize nameTextField,passwordTextField;
@synthesize user;


#pragma make lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view sendSubviewToBack:_bgImageView];
    
    user = [LightUser new];
    
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
- (void)onForgotPasswrod:(id)sender{

    LightFPCodeViewController *c = [[LightFPCodeViewController alloc]initWithNibName:@"LightFPCodeViewController" bundle:nil];
    [self.navigationController pushViewController:c  animated:YES];
    
}
- (void)onLogin:(id)sender{

    [self.view endEditing:YES];
    [self.view showHudWithText:@"正在登陆..."];
    __weak typeof(self) weakSelf = self;
    
    [user loginWithCode:nameTextField.text andPassword:passwordTextField.text andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate toMain];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
}
-(void)onRegister:(id)sender{
    
    LightRegViewController *regController = [[LightRegViewController alloc]initWithNibName:@"LightRegViewController" bundle:nil];
    regController.user = user;
    
    [self.navigationController pushViewController:regController animated:YES];
    
}



@end
