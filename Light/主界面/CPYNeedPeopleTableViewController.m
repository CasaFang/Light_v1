//
//  CPYNeedPeopleTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYNeedPeopleTableViewController.h"
#import "LightAccompany.h"
#import "UIView+Hud.h"
#import "CPYNeedPeopleTableViewCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "AddAccpmpanyViewController.h"
#import "NeedPeopleDetailViewController.h"

@interface CPYNeedPeopleTableViewController ()
{

    int  pageNo;
}

@property (strong , nonatomic) NSMutableArray *tableArray;

@end

static NSString *cellIdentifier = @"cpyneedpeoplecellidentifier";
static int TableViewRequestInterval = 10;

@implementation CPYNeedPeopleTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"需要人陪";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"msg_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAccompany:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 44, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableArray = [NSMutableArray new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf doRefresh];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf loadMoreData];
    }];
    
    pageNo = 1;
    
    [self.tableView triggerPullToRefresh];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAccompanySuccess:) name:LightAccompanyAddSuccessNoti object:nil];
}

- (void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAccompany:(UIButton *)btn{

    AddAccpmpanyViewController *c = [AddAccpmpanyViewController new];
    c.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c  animated:YES];
}

#pragma mark  loadMore
- (void)loadMoreData{
    
    pageNo = pageNo+1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightAccompany new] getAccompanyPeoplesWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *peoples, NSError *error) {
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        if (isSuccess) {
            
            [weakSelf.tableArray addObjectsFromArray:peoples];
            [weakSelf.tableView reloadData];
            
        }
        else
        {
            
        }

    }];
    
}
- (void)doRefresh
{
    pageNo = 1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightAccompany new] getAccompanyPeoplesWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *peoples, NSError *error) {
        
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        
        if (isSuccess) {
            
            weakSelf.tableArray = [peoples mutableCopy];
            [weakSelf.tableView reloadData];
            
        }
        else
        {
            
        }

        
    }];
}


#pragma mark -- noti
- (void)addAccompanySuccess:(NSNotification *)noti{

    [self.tableView triggerPullToRefresh];
}



#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPYNeedPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [CPYNeedPeopleTableViewCell initFromNib];
    }
    
    LightAccompany *accompany = [_tableArray objectAtIndex:indexPath.row];
    [cell displayCellWithAccompany:accompany];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LightAccompany *accompany = [_tableArray objectAtIndex:indexPath.row];
    
    NeedPeopleDetailViewController *c = [NeedPeopleDetailViewController new];
    c.accompany = accompany;
    c.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c animated:YES];
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

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
