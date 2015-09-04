//
//  IndexLeftViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftViewController.h"
#import "IndexLeftContentView.h"
#import "IndexLeftUserViewController.h"
#import "IndexLeftNotiTableViewController.h"
#import "IndexAccountViewController.h"
#import "IndexSettingViewController.h"
#import "IndexFeedBackViewController.h"
#import "IndexAboutViewController.h"
#import "LightMyShareManager.h"
#import "LightUser.h"
#import "AppDelegate.h"
#import <PKRevealController/PKRevealController.h>
#import "LightNavigationController.h"
#import "LightUser+Change.h"
#import "AvatarEditViewController.h"

@interface IndexLeftViewController ()<IndexLeftContentViewDelegate>

{
    IndexLeftContentView *contentView;
}


@end

@implementation IndexLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self buildUI];
    
//    [[LightMyShareManager shareUser].owner changeNameWithNewName:@"saberge1" andBlock:^(BOOL isSuccess, NSError *error) {
//        
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadAvatarSuccess:) name:LightUserChangeAvatarSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:LightUserChangeNickNameSuccessNoti object:nil];
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


#pragma mark -- noti
- (void)uploadAvatarSuccess:(NSNotification *)noti{

    contentView.avatarImageView.image = [UIImage imageWithData:noti.object];
}

- (void)changeNickName:(NSNotification *)noti{
    
    contentView.nameLabel.text = noti.object;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- arction

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height)];
    [self.view addSubview:container];
    container.backgroundColor = LightColor(0, 157, 212);
    
     contentView = [IndexLeftContentView initFromNib];
    [container addSubview:contentView];
    contentView.delegate = self;
    container.contentSize = contentView.frame.size;
    
}


#pragma mark -- indexLeftContentView delegate

- (void)contentView:(IndexLeftContentView *)v didSelectedSection:(NSInteger)section
{
    UIViewController *c = [IndexLeftUserViewController new];

    switch (section) {
        case 0:
        {
            c = [AvatarEditViewController new];
            ((AvatarEditViewController*)c).avatarImage = [contentView avatarImageView].image;
        }
            break;
        case 1:
        {
            c = [IndexLeftNotiTableViewController new];
        }
            break;
        case 2:
        {
            c = [IndexLeftUserViewController new];
        }
            break;
        case 3:
        {
            c = [IndexAccountViewController new];
        }
            break;
        case 4:
        {
            c = [IndexSettingViewController new];
        }
            break;
        case 5:
        {
            c = [IndexFeedBackViewController new];
        }
            break;
        case 6:
        {
            c = [IndexAboutViewController new];
        }
            break;
            
    }
    
    LightNavigationController *navi = [[LightNavigationController alloc]initWithRootViewController:c];
    
    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.revealController setFrontViewController:navi];
    [appDelegate.revealController showViewController:navi];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
