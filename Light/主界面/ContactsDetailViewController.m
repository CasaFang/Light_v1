//
//  ContactsDetailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "ContactsDetailViewController.h"
#import "ContactsDetailContentView.h"
#import "UIView+Hud.h"
#import "LightMyShareManager.h"
#import "LightUser+Friend.h"

@interface ContactsDetailViewController ()<ContactsDetailContentViewDelegate>
{
    ContactsDetailContentView *contentView;
}

@end

@implementation ContactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详细资料";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [contentView displayWithUser:_user];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    
    
    contentView = [ContactsDetailContentView initFromNib];
    CGRect f = contentView.frame;
    contentView.delegate = self;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --ContactsDetailContentViewDelegate

- (void)ContactsDetailContentViewDidClickedAddFriend{

    [self.view showHudWithText:@"正在发送好友申请..."];
    
    __weak typeof(self) weakSelf = self;
    [[LightMyShareManager shareUser].owner addFriend:_user andBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
        
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];
 
    
}
@end
