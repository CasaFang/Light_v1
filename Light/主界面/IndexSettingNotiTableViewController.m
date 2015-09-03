//
//  IndexSettingNotiTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexSettingNotiTableViewController.h"
#import "UIView+Hud.h"
#import "LightNoti.h"
#import "IndexSettingNotiTableViewCell.h"

@interface IndexSettingNotiTableViewController ()

@property (strong , nonatomic) NSMutableArray *tableArray;

@end

static NSString *cellIdentifier = @"indexsettingnoticellidentifier";
@implementation IndexSettingNotiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新消息通知";
    
    _tableArray = [NSMutableArray new];
    
    [self requestData];
}

- (void)requestData{
    
    [self.view showHudWithText:@"请稍等..."];
    
    __weak typeof(self) weakSelf = self;
    
    [[LightNoti new] getNotisBlock:^(BOOL isSuccess, NSArray *notis, NSError *error) {
        [weakSelf.view hideHud];
        if (isSuccess) {
            weakSelf.tableArray = [notis mutableCopy];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndexSettingNotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [IndexSettingNotiTableViewCell initFromNib];
    }
    
    LightNoti *expert = [_tableArray objectAtIndex:indexPath.row];
    [cell displayCellWithNoti:expert];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
