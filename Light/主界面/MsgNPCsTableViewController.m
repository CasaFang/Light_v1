//
//  MsgNPCsTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgNPCsTableViewController.h"
#import "MsgNPCsTableViewCell.h"
#import "UIView+Hud.h"
#import <RongIMKit/RongIMKit.h>

@interface MsgNPCsTableViewController ()

@property (strong , nonatomic) NSMutableArray *tableArray;

@end

static NSString *cellIdentifier = @"msgNPCsTableCellIndentifier";
@implementation MsgNPCsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Light服务";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _tableArray = [NSMutableArray new];
    
    [self requestData];
    
}

- (void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestData{
    
    [self.view showHudWithText:@"请稍等..."];
    
    __weak typeof(self) weakSelf = self;
    
    [[LightNPC new] getNpcsWithBlock:^(BOOL isSuccess, NSArray *npcs, NSError *error) {
        [weakSelf.view hideHud];
        
        if (isSuccess)
        {
            weakSelf.tableArray = [npcs mutableCopy];
            [weakSelf.tableView reloadData];
        }
    }];
    
}

- (void)openConversionWithNpc:(LightNPC *)npc
{

    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)npc.Id];
    conversationVC.userName = npc.name;
    conversationVC.title = npc.name;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgNPCsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [MsgNPCsTableViewCell initFromNib];
    }
    
    LightNPC *npc = [_tableArray objectAtIndex:indexPath.row];
    [cell displayCellWithNPC:npc];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LightNPC *npc = [_tableArray objectAtIndex:indexPath.row];
    
    [self openConversionWithNpc:npc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
    
}



@end
