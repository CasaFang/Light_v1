//
//  EmailEditViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EmailEditViewController.h"
#import "EmailEditContentView.h"
#import "UIView+Hud.h"
#import "NSString+Extention.h"
#import "EmailValidateViewController.h"
#import "LightUser+Register.h"

@interface EmailEditViewController ()<UIAlertViewDelegate>
{
    EmailEditContentView *contentView;
}

@end

@implementation EmailEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
    
    contentView.emailTextField.text = _email;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next:(UIButton *)btn{

    NSString *email = contentView.emailTextField.text;
    
    if (email == nil||email.trimWhiteSpace.length == 0 ) {
        
        [self.view showTipAlertWithContent:@"请填写邮箱"];
        return;
        
    }
    if (!email.isEmailFormat) {
        
        [self.view showTipAlertWithContent:@"请填写正确的邮箱格式"];
        return;
    }
    
    if ([_email isEqualToString:email]) {
        [self.view showTipAlertWithContent:@"俩次邮箱一致，确定要修改邮箱吗?"];
        return;
    }
    
    NSString *content = [NSString stringWithFormat:@"我们将发送验证码到这个邮箱 %@",email];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认邮箱地址" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    alert.tag = 200;
    [alert show];

}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [EmailEditContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 200) {
        
        if (buttonIndex == 1) {
            
            [self.view showHudWithText:@"正在请求验证码..."];
            
            __weak typeof(self)  weakSelf = self;
            
            LightUser *user = [LightMyShareManager shareUser].owner;
            
            [user ChangeWithEmailCode:contentView.emailTextField.text andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
                
                [weakSelf.view hideHud];
                
                if (isSuccess) {
                    
                    EmailValidateViewController *c = [[EmailValidateViewController alloc]init];
                    c.email = contentView.emailTextField.text;
                    [self.navigationController pushViewController:c  animated:YES];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                    [alert show];
                }
                
            }];
        }
    }
}

@end
