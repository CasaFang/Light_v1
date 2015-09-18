//
//  LoveAuthTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveAuthTableViewController.h"
#import "LoveAuthTableViewCell.h"
#import <SVPullToRefresh.h>
#import "LightAuth.h"
#import "LoveAuthAddViewController.h"
#import "MarryCertificationViewController.h"
#import "AuthDetailViewController.h"
#import "LightMyShareManager.h"
#import "LightUser.h"

static NSString * const cellIdentifer = @"loveAuthCellIdentifier";
static int TableViewRequestInterval = 10;

@interface LoveAuthTableViewController ()
{
    NSInteger pageNo;
}

@property (strong , nonatomic) NSMutableArray *tableAuths;

@end

@implementation LoveAuthTableViewController
@synthesize tableAuths;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Light 证书墙";
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"我的认证" style:UIBarButtonItemStyleDone target:self action:@selector(myAuth:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setImage:[UIImage imageNamed:@"msg_add"] forState:UIControlStateNormal];
//    [addBtn addTarget:self action:@selector(addAuth:) forControlEvents:UIControlEventTouchUpInside];
//    addBtn.frame = CGRectMake(0, 0, 44, 44);
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    tableAuths = [NSMutableArray new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf doRefresh];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf loadMoreData];
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    pageNo = 1;
    
    [self.tableView triggerPullToRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)myAuth:(UIButton *)btn{

    AuthDetailViewController *c = [AuthDetailViewController new];
    c.title = @"我的认证";
    c.marryPageId = [LightMyShareManager shareUser].owner.marryPageId;
    [self.navigationController pushViewController:c animated:YES];
    
}
#pragma mark  ---
- (void)addAuth:(UIButton *)btn{

    LoveAuthAddViewController *c = [[LoveAuthAddViewController alloc]init];
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark  loadMore
- (void)loadMoreData{
    
    pageNo = pageNo+1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightAuth new] getAuthsWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *auths, NSError *error) {
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        
        if (isSuccess) {
            
            [weakSelf.tableAuths addObjectsFromArray:auths];
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
    
    [[LightAuth new] getAuthsWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *auths, NSError *error) {
       
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        
        if (isSuccess) {
            
            weakSelf.tableAuths = [auths mutableCopy];
            [weakSelf.tableView reloadData];
            
        }
        else
        {
            
        }
    }];
    }

#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoveAuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (cell == nil) {
        
        cell = [LoveAuthTableViewCell initFromNib];
    }
    LightAuth *auth = [tableAuths objectAtIndex:indexPath.row];
    [cell disPlayViewWith:auth];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     LightAuth *auth = [tableAuths objectAtIndex:indexPath.row];
    AuthDetailViewController *c = [AuthDetailViewController new];
    c.marryPageId = [NSString stringWithFormat:@"%ld",(long)auth.Id];
    c.title = @"认证详情";
    [self.navigationController pushViewController:c animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableAuths.count;
    
}
#pragma mark -- scroll delegate
// 控制下拉刷新时  同时出发上拉的方法  ？？奇怪没有再库里看到这个控制项,没有办法只能自己控制下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float lengthForTriggerSVPullAction = scrollView.contentOffset.y;
    
    if (lengthForTriggerSVPullAction<= 50)
    {
        self.tableView.infiniteScrollingView.enabled = NO;
    }
    else
    {
        self.tableView.infiniteScrollingView.enabled = YES;
        self.tableView.showsInfiniteScrolling = YES;
    }
    
}


@end
