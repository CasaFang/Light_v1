//
//  ChatListViewController.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "ChatListViewController.h"
#import "LightRongYunManager.h"
#import "MsgMsgHeadView.h"
#import "MsgNPCsTableViewController.h"
#import "LightUser+Friend.h"
#import "LightNPC.h"
#import "LightMyShareManager.h"
#import "MsgNewFriendsTableViewController.h"
#import "LightPushCenter.h"


@interface ChatListViewController ()<MsgMsgHeadViewDelegate>
{
    MsgMsgHeadView *npcHeadView;
}

@end

@implementation ChatListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (npcHeadView == nil) {
        
        npcHeadView = [MsgMsgHeadView initFromNib];
        npcHeadView.delegate  = self;
        npcHeadView.backgroundColor = [UIColor whiteColor];
        npcHeadView.titleLabel.text = @"Light系统服务";
        
        CGRect f1 = npcHeadView.frame;
        f1.size.width = WINSIZE.width;
        f1.origin.y = 0;
        f1.size.height = 70;
        npcHeadView.frame = f1;
        
        [self.view addSubview:npcHeadView];
        
        CGRect f = self.conversationListTableView.frame;
        f.origin.y = npcHeadView.frame.size.height+npcHeadView.frame.origin.y;
        f.size.height = f.size.height- npcHeadView.frame.size.height;
        self.conversationListTableView.frame = f;
    }
    
    
    [self.view bringSubviewToFront:npcHeadView];
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    
}


- (void)openConversionWithUser:(LightUser *)user
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)user.Id];
    conversationVC.userName = user.name;
    conversationVC.title = user.name;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

#pragma mark --head Delegate
- (void)msgMsgHeadDidClickedView:(MsgMsgHeadView *)v
{
    if ([v isEqual:npcHeadView]) {
        
        // 进入系统NPC界面
        MsgNPCsTableViewController *c = [MsgNPCsTableViewController new];
        c.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:c animated:YES];
    }
}




@end