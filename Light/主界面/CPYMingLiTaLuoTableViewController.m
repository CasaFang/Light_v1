//
//  CPYMingLiTaLuoTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYMingLiTaLuoTableViewController.h"
#import "CPYMingLiTaLuoTableViewCell.h"
#import "UIView+Hud.h"
#import "LightExperts.h"
#import <RongIMKit/RongIMKit.h>

@interface CPYMingLiTaLuoTableViewController ()

@property (strong , nonatomic) NSMutableArray *tableArray;

@end

static NSString *cellIdentifier = @"cpyminglitaluocellidentifier";;
@implementation CPYMingLiTaLuoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Light 塔罗";
    
    _tableArray = [NSMutableArray new];
    
    [self requestData];
}

- (void)requestData{
    
    [self.view showHudWithText:@"请稍等..."];
    
    __weak typeof(self) weakSelf = self;
    
    [[LightExperts new] getExpertsWithField:LightExpertFieldMingLiShi andBlock:^(BOOL isSuccess, NSArray *experts, NSError *error) {
        
        [weakSelf.view hideHud];
        if (isSuccess) {
            weakSelf.tableArray = [experts mutableCopy];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPYMingLiTaLuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [CPYMingLiTaLuoTableViewCell initFromNib];
    }
    
    LightExperts *expert = [_tableArray objectAtIndex:indexPath.row];
    [cell displayCellWithExperts:expert];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     LightExperts *expert = [_tableArray objectAtIndex:indexPath.row];
    [self openConversionWithNpc:expert];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
    
}

- (void)openConversionWithNpc:(LightExperts *)npc
{
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)npc.Id];
    conversationVC.userName = npc.name;
    conversationVC.title = npc.name;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}





@end
