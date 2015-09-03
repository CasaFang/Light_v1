//
//  LightRegSexViewController.m
//  Light-iOS
//
//  Created by FLY on 15/6/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightRegSexViewController.h"
#import "AppDelegate.h"
#import "UIView+Hud.h"
#import "LightUser+Register.h"

@interface LightRegSexViewController ()
@property (retain, nonatomic) IBOutlet UILabel *biometricSexText;
@property (retain, nonatomic) IBOutlet UILabel *psychologySexText;

@property (retain, nonatomic) IBOutlet UIButton *bioMaleButton;
@property (retain, nonatomic) IBOutlet UIButton *bioOtherButton;
@property (retain, nonatomic) IBOutlet UIButton *bioFemaleButton;
@property (retain, nonatomic) IBOutlet UIButton *psyMaleButton;
@property (retain, nonatomic) IBOutlet UIButton *psyOtherButton;
@property (retain, nonatomic) IBOutlet UIButton *psyFemaleButton;
@property (nonatomic,strong) UIImageView *backgroundImageView;


- (IBAction)onPsychologySexSelected:(id)sender;
- (IBAction)onBiometricSexSelected:(id)sender;
- (IBAction)onBack:(id)sender;

@end

@implementation LightRegSexViewController
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
- (void)onBiometricSexSelected:(id)sender
{
    
    [self.view endEditing:YES];
    [self.view showHudWithText:@"正在注册用户信息..."];
    
    __weak typeof(self)  weakSelf = self;
    
    UIButton *btn = (UIButton *)sender;
    user.society_gender = btn.tag;
    
    [user addRegisterWithPassword:user.password andName:user.name  andSociety_gender:user.society_gender andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
       
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
- (void)onPsychologySexSelected:(id)sender
{
    [self.view endEditing:YES];
    [self.view showHudWithText:@"正在注册用户信息..."];
    
    __weak typeof(self)  weakSelf = self;
    UIButton *btn = (UIButton *)sender;
    user.physiology_gender = btn.tag;
    
    [user addRegisterWithPassword:user.password andName:user.name andPhysiology_gender:user.physiology_gender  andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
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

- (void)onBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
