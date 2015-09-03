//
//  IndexSettingViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexSettingViewController.h"
#import "AppDelegate.h"
#import "IndexSettingContentView.h"
#import "LightRongYunManager.h"
#import "AppDelegate.h"
#import "AppInfo.h"
#import "UIView+Hud.h"

@interface IndexSettingViewController ()<IndexSettingContentViewDelegate,UIAlertViewDelegate>
{
    AppInfo *appinfo;
}

@end

@implementation IndexSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
    
    
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
    
    
    IndexSettingContentView *contentView = [IndexSettingContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


#pragma mark -- 
- (void)settingContentView:(IndexSettingContentView *)v didSelectedSection:(NSInteger)section{

    switch (section) {
        case 0:
        {
            [self.view showHudWithText:@"请求版本信息..."];
            appinfo = [AppInfo new];
            [appinfo requestAppInfoWithVersion_code:100 andBlock:^(BOOL isSuccess ,BOOL isNewVersion, NSError *error) {
               
                [self.view hideHud];
                
                if (isSuccess) {
                    
                    if (isNewVersion)
                    {
                        
                        if (appinfo.is_force) {
                            
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:appinfo.update_log delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
                            [alert show];
                            
                        }
                        else{
                        
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:appinfo.update_log delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新",@"取消", nil];
                            [alert show];
                        
                        }
                    }
                    else{
                    
                        [self.view showTipAlertWithContent:@"当前是最新版本"];
                    }
                    
                }else{
                    
                    [self.view showTipAlertWithContent:error.domain];
                }
            }];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            [[LightRongYunManager shareManager] logout];
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate toLogin];
            
        }
            break;
    }


}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appinfo.url]];
    }
}

@end
