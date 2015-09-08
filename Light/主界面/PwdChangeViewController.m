//
//  PwdChangeViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PwdChangeViewController.h"
#import "PwdChangeContentView.h"
#import "LightUser+Change.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"
#import "NSString+Extention.h"

@interface PwdChangeViewController ()<PwdChangeContentViewDelegate>
{
    PwdChangeContentView *contentView;
}

@end

@implementation PwdChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置密码";
    
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
    container.backgroundColor = LightColor(242, 242, 242);
    container.alwaysBounceVertical = YES;
    
    
    contentView = [PwdChangeContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


#pragma mark --PwdChangeContentViewDelegate
- (void)pwdChangeContentViewDidCompleted:(PwdChangeContentView *)v{

    [self.view endEditing:YES];
    NSString *pwd = contentView.nPwdTextField.text;
    NSString *pwd2 = contentView.confirmPwdTextField.text;
    
    if (!pwd||pwd.trimWhiteSpace.length == 0) {
        
        [self.view showTipAlertWithContent:@"密码不能为空"];
        return;
    }
    if (!pwd2||pwd2.trimWhiteSpace.length == 0) {
        
        [self.view showTipAlertWithContent:@"密码不能为空"];
        return;
    }
    if ([pwd isEqualToString:pwd2]) {
        [self.view showTipAlertWithContent:@"俩次密码输入不一致"];
        return;
    }
    
    
    [self.view showHudWithText:@"正在修改密码..."];
    __weak typeof(self) weakSelf = self;
    
    LightUser *user = [LightMyShareManager shareUser].owner;
    
    [user updatePwdWithNewPwd:contentView.nPwdTextField.text andOriginalPwd:nil andCompletedBlock:^(BOOL isSuccess, NSError *error) {
       
        [weakSelf.view hideHud];
        if (isSuccess) {
            
        }
        else{
        
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];
    
}

@end
