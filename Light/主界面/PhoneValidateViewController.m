//
//  PhoneValidateViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PhoneValidateViewController.h"
#import "PhoneValidateContentView.h"
#import "LightMyShareManager.h"
#import "LightUser+Change.h"
#import "LightUser+Register.h"
#import "UIView+Hud.h"
#import <SMS_SDK/SMS_SDK.h>
#import "NSString+Extention.h"


@interface PhoneValidateViewController ()<PhoneValidateContentViewDelegate>{

    PhoneValidateContentView *contentView;
}

@end

@implementation PhoneValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"填写验证码";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [PhoneValidateContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --PhoneValidateContentViewDelegate
- (void)phoneValidateContentViewDidBinding:(PhoneValidateContentView *)view{
    
    LightUser *user = [LightMyShareManager shareUser].owner;
    
    __weak typeof(self) weakSelf = self;
    
    NSLog(@"%@",contentView.codeTextField.text);
    
    contentView.codeTextField.text = [contentView.codeTextField.text trimWhiteSpace];

    
    [SMS_SDK commitVerifyCode:contentView.codeTextField.text result:^(enum SMS_ResponseState state) {
    
//    [user validateCodeWithCode:contentView.codeTextField.text checkType:2 andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
//        if (isSuccess) {
        if (1==state){
            
            [self.view showHudWithText:@"正在绑定手机..."];
            
            [user updatePhoneWithPhone:_phone andCompletedBlock:^(BOOL isSuccess, NSError *error) {
                
                [weakSelf.view hideHud];
                
                if (isSuccess) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                
                    [weakSelf.view showTipAlertWithContent:error.domain];
                }
            }];
        }
        else
        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
}



@end
