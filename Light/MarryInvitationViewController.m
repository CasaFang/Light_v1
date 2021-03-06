//
//  MarryInvitationViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryInvitationViewController.h"
#import "MarryInvitationContentView.h"
#import "LightUser+Marry.h"
#import "UIView+Hud.h"

@interface MarryInvitationViewController ()<MarryInvitationContentViewDelegate>
{

    MarryInvitationContentView *contentView;
}

@end

@implementation MarryInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请函";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
    

    [contentView displayWithNoti:_noti];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = LightColor(242, 242, 242);
    
    
    contentView = [MarryInvitationContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}


#pragma mark -- MarryInvitationContentViewDelegate

- (void)marryInvitationContentViewDidRefused:(MarryInvitationContentView *)v{

    LightMarry *marry = _noti.notiObject;
    
    [self.view showHudWithText:@"请稍等..."];
    [[LightUser new] marryReponseWithMarryId:marry.Id andStatus:-1 andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hideHud];
        
        if (isSuccess) {
        
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
        
            [self.view showTipAlertWithContent:error.domain];
        
        }
        
    }];
}
- (void)marryInvitationContentViewDidAgreed:(MarryInvitationContentView *)v{

    LightMarry *marry = _noti.notiObject;
    
    [self.view showHudWithText:@"请稍等..."];
    [[LightUser new] marryReponseWithMarryId:marry.Id andStatus:1 andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hideHud];
        
        if (isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            
            [self.view showTipAlertWithContent:error.domain];
            
        }
        
    }];
}


@end
