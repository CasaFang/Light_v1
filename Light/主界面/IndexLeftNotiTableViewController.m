//
//  IndexNotiTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftNotiTableViewController.h"
#import "AppDelegate.h"
#import "LightNoti.h"
#import "UIView+Hud.h"
#import "IndexLeftNotiTableViewCell.h"
#import "MarryInvitationViewController.h"
#import "LightUser+Marry.h"
#import "MarryCertificationViewController.h"

@interface IndexLeftNotiTableViewController ()

@property (strong , nonatomic) NSMutableArray *tableArray;

@end

static NSString *cellIdentifier = @"indexleftnoticellidentifier";
@implementation IndexLeftNotiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通知";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(marryNoti:) name:LightUserMarryNoti object:nil];
    
    
    _tableArray = [NSMutableArray new];
    
    [self requestData];
    
    
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

#pragma mark -- noti
- (void)marryNoti:(NSNotification *)noti{

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
    IndexLeftNotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [IndexLeftNotiTableViewCell initFromNib];
    }
    
    LightNoti *noti = [_tableArray objectAtIndex:indexPath.row];
    [cell displayCellWithNoti:noti];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     LightNoti *noti = [_tableArray objectAtIndex:indexPath.row];
    
    if (noti.type == 3) {
        
        MarryInvitationViewController *c = [MarryInvitationViewController new];
        c.noti = noti;
        [self.navigationController pushViewController:c animated:YES];
    }
    else if(noti.type == 4)
    {
        MarryCertificationViewController *c = [MarryCertificationViewController new];
        [self.navigationController pushViewController:c animated:YES];
    }
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
    
}


@end
