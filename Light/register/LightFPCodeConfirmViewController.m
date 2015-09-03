//
//  LightFPCodeConfirmViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightFPCodeConfirmViewController.h"
#import "LightTextField.h"
#import "LightFPValidateViewController.h"
#import "LightUser+FindPwd.h"
#import "UIView+Hud.h"
#import "NSString+Extention.h"

@interface LightFPCodeConfirmViewController ()

@property (weak , nonatomic) IBOutlet UILabel *codeLabel;

@property (strong , nonatomic) LightUser *user;

- (IBAction)onNext:(id)sender;

- (IBAction)onCancle:(id)sender;

@end

@implementation LightFPCodeConfirmViewController
@synthesize code;
@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _codeLabel.text = code;
    user = [LightUser new];
    
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
    [self.view showHudWithText:@"正在验证..."];
    __weak typeof(self) weakSelf = self;
    
    [user validateCode:code andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
       
        [weakSelf.view hideHud];
        if (isSuccess) {
            
            LightFPValidateViewController *c = [[LightFPValidateViewController alloc]initWithNibName:@"LightFPValidateViewController" bundle:nil];
            c.user = user;
            
            if ([code isEmailFormat])
            {
                c.checkType = 1;
            }
            else
            {
                c.checkType = 2;
            }
            
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

-(void)onBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
