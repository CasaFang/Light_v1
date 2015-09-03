//
//  MsgNewFriendsTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgNewFriendsTableViewController.h"
#import "LightUser+Friend.h"
#import "MsgContactsTableViewCell.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"
#import "NewFriendsTableViewCell.h"


@interface MsgNewFriendsTableViewController ()<NewFriendsTableViewCellDelegate>

@property (strong , nonatomic) NSMutableArray *tableArray;

@end
static NSString *const cellIdentifier = @"msgNewTableCellIndentifier";

@implementation MsgNewFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新朋友";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _tableArray = [NSMutableArray new];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestData{
    
    [self.view showHudWithText:@"请稍等..."];
    
    __weak typeof(self) weakSelf = self;
    
    [[LightMyShareManager shareUser].owner getNewFriendsWithBLock:^(BOOL isSuccess, NSArray *newFriends, NSError *error) {
        
        [weakSelf.view hideHud];
        if (isSuccess) {
            weakSelf.tableArray = [newFriends mutableCopy];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [NewFriendsTableViewCell initFromNib];
        cell.delegate = self;
    }
    
    
    LightUser *user = [_tableArray objectAtIndex:indexPath.row];
    [cell disPlayCellWithUser:user];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark cell delegate
- (void)newFriendTableCell:(NewFriendsTableViewCell *)cell DidAgreedFriendWithUser:(LightUser *)user
{
    [self.view showHudWithText:@"请稍等..."];
    __weak typeof(self) weakSelf = self;
    
    [[LightMyShareManager shareUser].owner agreeAddFriend:user andBlock:^(BOOL isSuccess, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            [self requestData];
        }
        else{
            
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];
}

@end
