//
//  BindingEmailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "BindingEmailViewController.h"
#import "UnBindingEmailContentView.h"
#import "EmailEditViewController.h"
#import "BindingEmailContentView.h"
#import "NSString+Extention.h"
#import "LightUser+Change.h"
#import "UIView+Hud.h"
#import "LightUser+Change.h"
#import "LightMyShareManager.h"

@interface BindingEmailViewController ()<BindingEmailContentViewDelegate,UnBindingEmailContentViewDelegate,UIAlertViewDelegate>{

    BindingEmailContentView *bindingContentView;
    UnBindingEmailContentView *unbindingcontentView;
}

@end

@implementation BindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"绑定邮箱";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    if (_email&&_email.trimWhiteSpace.length >0) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
   
    [self buildUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edit:(UIButton *)btn{
    
    EmailEditViewController *c =[EmailEditViewController new];
    c.email = [LightMyShareManager shareUser].owner.email;
    c.title = @"修改邮箱";
    [self.navigationController pushViewController:c  animated:YES];
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    if (_email&&_email.trimWhiteSpace.length >0) {
        
        unbindingcontentView = [UnBindingEmailContentView initFromNib];
        CGRect f = unbindingcontentView.frame;
        f.size.width = WINSIZE.width;
        unbindingcontentView.frame = f;
        unbindingcontentView.delegate = self;
        
        [container addSubview:unbindingcontentView];
        container.contentSize = unbindingcontentView.frame.size;
        unbindingcontentView.phoneTextField.text = _email;
        unbindingcontentView.phoneTextField.enabled = NO;
    }
    else{
    
        bindingContentView = [BindingEmailContentView initFromNib];
        CGRect f = bindingContentView.frame;
        f.size.width = WINSIZE.width;
        bindingContentView.frame = f;
        bindingContentView.delegate = self;
        
        [container addSubview:bindingContentView];
        container.contentSize = bindingContentView.frame.size;
    }
}

#pragma mark --BindingEmailContentViewDelegate

- (void)bindingEmailContentViewDidBindingEmail:(BindingEmailContentView *)v{

    EmailEditViewController *c = [[EmailEditViewController alloc]init];
    c.email = [LightMyShareManager shareUser].owner.email;
    c.title = @"绑定邮箱";
    [self.navigationController pushViewController:c animated:YES];
   
}

#pragma mark -- UnBindingEmailContentViewDelegate
- (void)unBindingEmailContentViewDidUnbindingEmail:(UnBindingEmailContentView *)v{

    LightUser *user = [LightMyShareManager shareUser].owner;
    if (!user.phone) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"解绑失败" message:@"您缺少一个账号信息来登录到LIGHT，请先绑定手机号，再解绑该此邮箱地址。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.tag = 201;
        [alert show];
        
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"解绑手机" message:@"解绑后，您将无法使用此邮箱登陆LIGHT，也无法通过此邮箱找回密码。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解绑", nil];
    alert.tag = 200;
    [alert show];
}


#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            
            [self.view showHudWithText:@"正在解绑邮箱..."];
            
            __weak typeof(self) weakSelf = self;
            LightUser *user = [LightMyShareManager shareUser].owner;
            
            [user updateEmailWithEmail:@"" andCompletedBlock:^(BOOL isSuccess, NSError *error) {
                
                [weakSelf.view hideHud];
                
                if (isSuccess) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    
                    [weakSelf.view showTipAlertWithContent:error.domain];
                }
            }];

        }
    }
}
@end
