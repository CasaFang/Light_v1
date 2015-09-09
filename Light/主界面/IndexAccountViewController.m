//
//  IndexAccountViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAccountViewController.h"
#import "AppDelegate.h"
#import "IndexAccountContentView.h"
#import "PwdChangeViewController.h"
#import "BindingEmailViewController.h"
#import "BindingPhoneViewController.h"
#import "LightUser+Change.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"

@interface IndexAccountViewController ()<IndexAccountContentViewDelegate,UIAlertViewDelegate>
{
    IndexAccountContentView *contentView;
}

@end

@implementation IndexAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhoneNoti:) name:LightUserChangePhoneSuccessNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingEmailNoti:) name:LightUserChangeEmailSuccessNoti object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changPwdNoti:) name:LightUserChangePWDSuccessNoti object:nil];
    
    [contentView displayViewUser:[LightMyShareManager shareUser].owner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --actions
- (void)backToMain:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRevealController];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
     container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [IndexAccountContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --
- (void)accountContentView:(IndexAccountContentView *)v didSelectedSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            BindingPhoneViewController *c = [BindingPhoneViewController new];
            LightUser *user = [[LightMyShareManager shareUser] owner];
            c.phone = user.phone;
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
            BindingEmailViewController *c = [BindingEmailViewController new];
            LightUser *user = [[LightMyShareManager shareUser] owner];
            c.email = user.email;
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 2:
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证原密码" message:@"为了保护您的数据安全，修改前请填写原密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            alert.tag = 200;
            [alert show];
        }
            break;
        case 3:
        {
            // 支付宝
        }
            break;

    }
}


#pragma mark -- noti
- (void)changePhoneNoti:(NSNotification *)noti{
    
    [contentView displayViewUser:[LightMyShareManager shareUser].owner];
    [self.navigationController popToViewController:self animated:YES];
}

- (void)bindingEmailNoti:(NSNotification *)noti{
    
    [contentView displayViewUser:[LightMyShareManager shareUser].owner];
    
    [self.navigationController popToViewController:self animated:YES];
}

- (void)changPwdNoti:(NSNotification *)noti{
    
    [self.navigationController popToViewController:self animated:YES];
}


#pragma mark--UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            
            UITextField *field = [alertView textFieldAtIndex:0];
            NSString *inputPwd = field.text;
            
            if ([inputPwd isEqualToString:[LightMyShareManager shareUser].owner.password]) {
                
                PwdChangeViewController *c = [PwdChangeViewController new];
                [self.navigationController pushViewController:c animated:YES];
            }
            else{
            
                [self.view showTipAlertWithContent:@"请重新输入密码，如果密码丢失，可推出登录，重新找回密码"];
            }
        }
    }
}
@end
