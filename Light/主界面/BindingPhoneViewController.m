//
//  BindingPhoneViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "UnBindingPhoneContentView.h"
#import "PhoneEditViewController.h"
#import "LightMyShareManager.h"
#import "LightUser+Change.h"
#import "UIView+Hud.h"
#import "BindingPhoneContentView.h"
#import "NSString+Extention.h"
#import "PhoneEditViewController.h"

@interface BindingPhoneViewController ()<BindingPhoneContentViewDelegate,UIAlertViewDelegate,UnBindingPhoneContentViewDelegate>
{

    UnBindingPhoneContentView *unbindingcontentView;
    BindingPhoneContentView   *bindingContentView;
}

@end

@implementation BindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"绑定手机";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edit:(UIButton *)btn{
    
    PhoneEditViewController *c = [PhoneEditViewController new];
    c.phone = [LightMyShareManager shareUser].owner.phone;
    c.title = @"修改手机号";
    [self.navigationController pushViewController:c animated:YES];
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    if (_phone &&_phone.trimWhiteSpace.length >0) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
        self.navigationItem.rightBarButtonItem = rightItem;

        unbindingcontentView = [UnBindingPhoneContentView initFromNib];
        CGRect f = unbindingcontentView.frame;
        f.size.width = WINSIZE.width;
        unbindingcontentView.frame = f;
        unbindingcontentView.delegate = self;
        
        [container addSubview:unbindingcontentView];
        container.contentSize = unbindingcontentView.frame.size;
        
        unbindingcontentView.phoneTextField.text = _phone;
        unbindingcontentView.phoneTextField.enabled = NO;
    }
    else{

        bindingContentView = [BindingPhoneContentView initFromNib];
        CGRect f = bindingContentView.frame;
        f.size.width = WINSIZE.width;
        bindingContentView.frame = f;
        bindingContentView.delegate = self;
        
        [container addSubview:bindingContentView];
        container.contentSize = bindingContentView.frame.size;
    }
   
}

#pragma mark --UnBindingPhoneContentViewDelegate

- (void)unbindingPhoneContentViewDidUnbinding:(UnBindingPhoneContentView *)v{

    LightUser *user = [LightMyShareManager shareUser].owner;
    if (!user.email) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"解绑失败" message:@"您缺少一个账号信息来登录到LIGHT，请先绑定邮箱，再解绑该手机号。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.tag = 201;
        [alert show];
        
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"解绑手机" message:@"解绑后，您将无法使用手机号登陆LIGHT，也无法通过此号码找回密码。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解绑", nil];
    alert.tag = 200;
    [alert show];
    
}

#pragma mark --BindingPhoneContentViewDelegate
- (void)bindingPhoneContentViewDidBinding:(BindingPhoneContentView *)v{

    PhoneEditViewController *c = [PhoneEditViewController new];
    c.phone = [LightMyShareManager shareUser].owner.phone;
    c.title = @"绑定手机号";
    [self.navigationController pushViewController:c animated:YES];
    
}


#pragma mark --UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 200) {
        
        if (buttonIndex == 1) {
            
            [self.view showHudWithText:@"正在解绑手机..."];
            __weak typeof(self) weakSelf = self;
            
            [[LightMyShareManager shareUser].owner updatePhoneWithPhone:@"" andCompletedBlock:^(BOOL isSuccess, NSError *error) {
                
                [weakSelf.view hideHud];
                
                if (isSuccess) {
                    
                    [weakSelf.view showStatus:@"解绑成功"];
                }
                else{
                    
                    [weakSelf.view showTipAlertWithContent:error.domain];
                }
                
            }];

        }
    }
}
@end
