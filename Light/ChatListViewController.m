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
    MsgMsgHeadView *newFriendHeadView;
}

@end

@implementation ChatListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveRemotoNoti:) name:LightPushAddFriendNoti object:nil];
    
}

- (void)buildNPCUI
{
    
    if (npcHeadView == nil) {
        
        npcHeadView = [MsgMsgHeadView initFromNib];
        npcHeadView.delegate  = self;
        npcHeadView.backgroundColor = [UIColor whiteColor];
        npcHeadView.titleLabel.text = @"Light系统服务";
        
        CGRect f1 = npcHeadView.frame;
        f1.size.width = WINSIZE.width;
        f1.origin.y = newFriendHeadView == nil?0:newFriendHeadView.frame.size.height;
        f1.size.height = 70;
        npcHeadView.frame = f1;
        
        //    [self.conversationListTableView setTableHeaderView:msgHeadView];
        
        [self.view addSubview:npcHeadView];
    }
    else{
        
    }

}

- (void)buildNewFriendUI
{
    
    if (newFriendHeadView == nil) {
        
        newFriendHeadView = [MsgMsgHeadView initFromNib];
        newFriendHeadView.delegate  = self;
        newFriendHeadView.backgroundColor = [UIColor whiteColor];
        newFriendHeadView.titleLabel.text = @"好友申请";
        CGRect f1 = newFriendHeadView.frame;
        f1.size.width = WINSIZE.width;
        f1.origin.y = 0;
        f1.size.height = 70;
        newFriendHeadView.frame = f1;
        
        //    [self.conversationListTableView setTableHeaderView:msgHeadView];
        
        [self.view addSubview:newFriendHeadView];
        
    }
    else{
    
    }
    
}

- (void)resetTableViewFrame{

    if (newFriendHeadView) {
        
        CGRect f = self.conversationListTableView.frame;
        f.origin.y = newFriendHeadView.frame.size.height;
        f.size.height = f.size.height- newFriendHeadView.frame.size.height;
        self.conversationListTableView.frame = f;
    }
    else{
    
        CGRect f = self.conversationListTableView.frame;
        f.origin.y = 0;
        f.size.height = f.size.height+ newFriendHeadView.frame.size.height;
        self.conversationListTableView.frame = f;
    }
    
    if (npcHeadView) {
        
        if (newFriendHeadView) {
            
            CGRect f = self.conversationListTableView.frame;
            f.origin.y = newFriendHeadView.frame.size.height+npcHeadView.frame.size.height;
            f.size.height = f.size.height- newFriendHeadView.frame.size.height;
            self.conversationListTableView.frame = f;
        }
        else{
        
            CGRect f = self.conversationListTableView.frame;
            f.origin.y = newFriendHeadView.frame.size.height;
            f.size.height = f.size.height+ newFriendHeadView.frame.size.height;
            self.conversationListTableView.frame = f;
        }
       
    }
    else{
        
        if (newFriendHeadView) {
            
            CGRect f = self.conversationListTableView.frame;
            f.origin.y = newFriendHeadView.frame.size.height;
            f.size.height = f.size.height+ newFriendHeadView.frame.size.height;
            self.conversationListTableView.frame = f;
        }
        else{
            
            CGRect f = self.conversationListTableView.frame;
            f.origin.y = 0;
            f.size.height = f.size.height- newFriendHeadView.frame.size.height;
            self.conversationListTableView.frame = f;
        }

    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[LightMyShareManager shareUser].owner getNewFriendsWithBLock:^(BOOL isSuccess, NSArray *newFriends, NSError *error) {
        
        if (isSuccess) {
            
            if (newFriends.count>=1) {
                
                if (!newFriendHeadView) {
                    
                    [self buildNewFriendUI];
                     [self resetTableViewFrame];
                }
                
            }
            else{
                
                [newFriendHeadView removeFromSuperview];
                newFriendHeadView = nil;
                 [self resetTableViewFrame];
            }
            
            [self.view bringSubviewToFront:newFriendHeadView];
            [[LightNPC new] getNpcsWithBlock:^(BOOL isSuccess, NSArray *npcs, NSError *error) {
                
                if (isSuccess) {
                    
                    if (npcs.count>=1) {
                        
                        if (!npcHeadView) {
                            
                            [self buildNPCUI];
                             [self resetTableViewFrame];
                        }
                        
                    }
                }
                else{
                    
                    [npcHeadView removeFromSuperview];
                     npcHeadView = nil;
                     [self resetTableViewFrame];
                }
                
                [self.view bringSubviewToFront:npcHeadView];
            }];
        }
    }];
    
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


/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"2440";
    conversationVC.userName = @"my";
    conversationVC.title = @"2440";
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
    else if ([v isEqual:newFriendHeadView]){
    
        MsgNewFriendsTableViewController *c = [MsgNewFriendsTableViewController new];
        
        NSInteger newFirendCount = newFriendHeadView.badgeLabel.text.integerValue;
        
        newFriendHeadView.badgeLabel.text = @"";
        newFriendHeadView.badgeLabel.hidden = YES;
        
        [[LightPushCenter shareCenter] didReadRemotoPushNotiWithCount:newFirendCount];
        
        c.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c animated:YES];
    }
   
}


#pragma mark -- remote push noti
- (void)reciveRemotoNoti:(NSNotification *)noti{

    NSString *badgeVale = [[noti.object valueForKey:@"aps"] valueForKey:@"badge"];
    
    newFriendHeadView.badgeLabel.text = [NSString stringWithFormat:@"%@",badgeVale];
    newFriendHeadView.badgeLabel.hidden = NO;
}

@end