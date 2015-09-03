//
//  MsgViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/17.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgHeadTabView.h"
#import "ChatListViewController.h"
#import "ContactsTableViewController.h"
#import "LightRongYunManager.h"
#import "UIView+Hud.h"
#import "ContactsSearchViewController.h"
#import "LightNavigationController.h"

@interface MsgViewController ()<MsgHeadTabViewDelegate,ContactsTableViewControllerDelegate>
{
    MsgHeadTabView *tabView;
    UIView *container;
    ChatListViewController *chatListViewController;
    ContactsTableViewController *contactsTableViewController;
}

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title = @"消息";
    
    [self buildUI];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"msg_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addMsgOrFriend:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 44, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addMsgOrFriend:(UIButton *)btn{
    
    if (chatListViewController.view.hidden) {
        
        ContactsSearchViewController *c = [ContactsSearchViewController new];
        c.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c  animated:YES];
    }
    else{
    
        ContactsTableViewController *c  =[ContactsTableViewController new];
        c.delegate  =self;
        
        [self presentViewController:[[LightNavigationController alloc] initWithRootViewController:c]  animated:YES completion:^{
            
            [c hideLeftCancleBtn:NO];
        }];
    }
}

- (void)buildUI{

    container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64+49))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    
    tabView = [MsgHeadTabView initFromNib];
    tabView.delegate = self;
    [container addSubview:tabView];
    [tabView setSelectedIndex:0];
    
}

- (void)didSelectedMsgTab:(MsgHeadTabView *)view{

    [[LightRongYunManager shareManager] synchronizationUserWithBlock:^(BOOL isSucess, NSError *error) {
        
    }];
    if (chatListViewController == nil)
    {
        
        chatListViewController = [ChatListViewController new];
        chatListViewController.view.frame = CGRectMake(0, tabView.frame.size.height, WINSIZE.width, container.frame.size.height-tabView.frame.size.height);
        [container addSubview:chatListViewController.view];
        [self addChildViewController:chatListViewController];

    }
    else{
    
        [chatListViewController refreshConversationTableViewIfNeeded];
    }
    
    contactsTableViewController.view.hidden = YES;
    chatListViewController.view.hidden = NO;
    
}

#pragma mark --MsgHeadTabViewDelegate

- (void)didSelectedContactsTab:(MsgHeadTabView *)view{
    
    if (contactsTableViewController == nil) {
        
        contactsTableViewController = [[ContactsTableViewController alloc]init];
        contactsTableViewController.view.frame = CGRectMake(0, tabView.frame.size.height, WINSIZE.width, container.frame.size.height-tabView.frame.size.height);
        [container addSubview:contactsTableViewController.view];
        contactsTableViewController.delegate = self;
        [self addChildViewController:contactsTableViewController];
    }
    chatListViewController.view.hidden = YES;
    contactsTableViewController.view.hidden = NO;
    
}

#pragma mark -- ContactsTableViewControllerDelegate
- (void)contacts:(ContactsTableViewController *)contact didSelectedUser:(LightUser *)user{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [chatListViewController openConversionWithUser:user];
}
@end
