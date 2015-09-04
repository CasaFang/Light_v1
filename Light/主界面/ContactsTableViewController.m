//
//  ContactsTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "LightMyShareManager.h"
#import "LightUser+Friend.h"
#import "UIView+Hud.h"
#import "MsgContactsTableViewCell.h"
#import "MsgMsgHeadView.h"
#import "MsgNewFriendsTableViewController.h"
#import "LightPushCenter.h"

static NSString *contactCellIdentifier = @"msgContactsTableCellIndentifier";

@interface ContactsTableViewController ()<UISearchBarDelegate,MsgMsgHeadViewDelegate>
{
     MsgMsgHeadView *newFriendHeadView;
}

@property (strong , nonatomic) NSArray *contacts;
@property (strong , nonatomic) UIButton *cancleBtn;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择联系人";
    // 设置索引字体的颜色
    self.tableView.sectionIndexColor = LightBlue;
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexBackgroundColor = LightWhite;
    self.tableView.separatorColor = LightColor(235, 235, 235);
    
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setImage:[UIImage imageNamed:@"regiser_back"] forState:UIControlStateNormal];
    [_cancleBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    _cancleBtn.frame = CGRectMake(0, 0, 44, 44);
    _cancleBtn.hidden = YES;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_cancleBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFriendRequestSuccess:) name:LightUserAddFriendsSuccessNoti object:nil];
    
    [self requestContacts];
    
    newFriendHeadView = [MsgMsgHeadView initFromNib];
    newFriendHeadView.delegate  = self;
    newFriendHeadView.backgroundColor = [UIColor whiteColor];
    newFriendHeadView.titleLabel.text = @"好友申请";
    CGRect f1 = newFriendHeadView.frame;
    f1.size.width = WINSIZE.width;
    f1.origin.y = 0;
    f1.size.height = 70;
    newFriendHeadView.frame = f1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveRemotoNoti:) name:LightPushAddFriendNoti object:nil];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[LightMyShareManager shareUser].owner getNewFriendsWithBLock:^(BOOL isSuccess, NSArray *newFriends, NSError *error) {
        
        if (newFriends.count>0) {
            
            [self.tableView setTableHeaderView:newFriendHeadView];
        }
        else{
            [self.tableView setTableHeaderView:nil];
        }
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cancle:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -- noti
- (void)hideLeftCancleBtn:(BOOL)isHidden{
    _cancleBtn.hidden = isHidden;
    if (!isHidden) {
        
        self.tableView.tableHeaderView = nil;
    }
}
- (void)addFriendRequestSuccess:(NSNotification *)noti
{
    [self requestContacts];
}

#pragma mark -- actions
- (void)requestContacts
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithText:@"正在请求好友..."];
    [[LightMyShareManager shareUser].owner getFriendsWithBlock:^(BOOL isSuccess, NSArray *friends, NSError *error) {
        
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            weakSelf.contacts = friends;
            [weakSelf.tableView reloadData];
        }
        else
        {
        
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _contacts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[_contacts objectAtIndex:section] valueForKey:@"array"] count];
}

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgContactsTableViewCell *contactCell = [tableView dequeueReusableCellWithIdentifier:contactCellIdentifier];
    
    if (contactCell == nil) {
        
        contactCell = [MsgContactsTableViewCell initFromNib];
    }
    
    LightUser *user = [[[_contacts objectAtIndex:indexPath.section] valueForKey:@"array"] objectAtIndex:indexPath.row];
    [contactCell disPlayCellWithUser:user];
    
    return contactCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LightUser *user = [[[_contacts objectAtIndex:indexPath.section] valueForKey:@"array"] objectAtIndex:indexPath.row];
    
    if ([_delegate respondsToSelector:@selector(contacts:didSelectedUser:)]) {
        [_delegate contacts:self didSelectedUser:user];
    }
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//
//}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.backgroundColor = LightColor(235, 235, 235);
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[_contacts objectAtIndex:section] valueForKey:@"title"];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[LightMyShareManager shareUser].owner getIndexArray];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)_searchBar
{
    _searchBar.showsCancelButton = NO;
}


#pragma mark --head Delegate
- (void)msgMsgHeadDidClickedView:(MsgMsgHeadView *)v
{
    if ([v isEqual:newFriendHeadView]){
        
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
