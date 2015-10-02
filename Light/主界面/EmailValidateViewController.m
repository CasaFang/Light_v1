//
//  EmailValidateViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EmailValidateViewController.h"
#import "EmailValidateContentView.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"
#import "LightUser+Register.h"

@interface EmailValidateViewController ()<EmailValidateContentViewDelegate>
{
    EmailValidateContentView *contentView;
}

@end

@implementation EmailValidateViewController

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
    
    
    contentView = [EmailValidateContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --EmailValidateContentViewDelegate
- (void)emailValidateContentViewDidBinding:(EmailValidateContentView *)view{

    LightUser *user = [LightMyShareManager shareUser].owner;
    
     __weak typeof(self) weakSelf = self;
    
    [user validateCodeWithCode:contentView.codeTextField.text checkType:1 andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            [self.view showHudWithText:@"正在绑定邮箱..."];
            
            [user updateEmailWithEmail:_email andCompletedBlock:^(BOOL isSuccess, NSError *error) {
                
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
}

@end
