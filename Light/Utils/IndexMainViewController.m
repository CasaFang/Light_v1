//
//  IndexMainViewController.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexMainViewController.h"
#import <SVPullToRefresh.h>
#import "IndexMainTableViewCell.h"
#import "LightArticle.h"
#import "AppDelegate.h"
#import "MainArticleDetailViewController.h"
#import "LightNPC.h"
#import "UIView+Hud.h"
#import "IndexMainNPCSTableViewCell.h"
#import <RongIMKit/RongIMKit.h>

static int TableViewRequestInterval = 10;

static NSString *cellIdentifier = @"indexMainTableCellIndentifier";

@interface IndexMainViewController ()<UITableViewDataSource,UITableViewDelegate,IndexMainNPCSTableViewCellDelegate>

{
    NSInteger pageNo;
    BOOL isShowLeftView;
}

@property (strong , nonatomic) UITableView *tableView;

@property (strong , nonatomic) NSMutableArray *tableArticles;

@end

@implementation IndexMainViewController
@synthesize tableArticles;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title =  @"首页";
    
    UIButton *swipeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [swipeBtn setImage:[UIImage imageNamed:@"index_swipe"] forState:UIControlStateNormal];
    [swipeBtn addTarget:self action:@selector(swipeLeftOrRight:) forControlEvents:UIControlEventTouchUpInside];
    swipeBtn.frame = CGRectMake(0, 0, 44, 44);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:swipeBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64+49)) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableArticles = [NSMutableArray new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf doRefresh];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf loadMoreData];
    }];
    
    pageNo = 1;

    [self.tableView triggerPullToRefresh];
    
}


#pragma mark  loadMore
- (void)loadMoreData{

    pageNo = pageNo+1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightArticle new] getArticlesWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *articles, NSError *error) {
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        if (isSuccess) {
            
            [weakSelf.tableArticles addObjectsFromArray:articles];
            [weakSelf.tableView reloadData];
            
        }
        else
        {
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];

}
- (void)doRefresh
{
    pageNo = 1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightArticle new] getArticlesWithPageSize:TableViewRequestInterval andPageNo:pageNo andVersion:100 andCompeletedBlock:^(BOOL isSuccess, NSArray *articles, NSError *error) {
        
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        
        if (isSuccess) {
            
            weakSelf.tableArticles = [articles mutableCopy];
            
            [[LightNPC new] getNpcsWithBlock:^(BOOL isSuccess, NSArray *npcs, NSError *error) {
                
                if (isSuccess) {
                    
                    [weakSelf.tableArticles insertObject:npcs atIndex:1];
                    [weakSelf.tableView reloadData];
                }
                else{
                    
                    [weakSelf.view showTipAlertWithContent:error.domain];
                
                }
                
            }];

        }
        else
        {
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];
    
   
}


#pragma mark -- action

- (void)swipeLeftOrRight:(UIButton *)btn
{
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [delegate showLeftOrCenter];
}
#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndexMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    IndexMainNPCSTableViewCell *cellNPCS = [tableView dequeueReusableCellWithIdentifier:@"IndexMainNPCSTableViewCell"];
    
    
    if (indexPath.row == 1) {
        
        if (cellNPCS == nil ) {
            cellNPCS = [IndexMainNPCSTableViewCell initFromNib];
            cellNPCS.delegate = self;
        }
        
        NSArray *npcs = [tableArticles objectAtIndex:indexPath.row];
        [cellNPCS disPlayWithNPCS:npcs];
        
        return cellNPCS;
        
    }
    else{
    
        if (cell == nil) {
            
            cell = [IndexMainTableViewCell initFromNib];
        }
        LightArticle *article = [tableArticles objectAtIndex:indexPath.row];
        [cell displayCellWithArticle:article];
    }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     LightArticle *article = [tableArticles objectAtIndex:indexPath.row];
    
    if (indexPath.row == 1) {
        return;
    }
    
    MainArticleDetailViewController *c = [MainArticleDetailViewController new];
    c.article = article;
    c.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 130;
    }
    LightArticle *article = [tableArticles objectAtIndex:indexPath.row];
    return [IndexMainTableViewCell heightForCellWithArticle:article];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 114;
    }
    
    LightArticle *article = [tableArticles objectAtIndex:indexPath.row];
    return [IndexMainTableViewCell heightForCellWithArticle:article];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArticles.count;

}
#pragma mark -- scroll delegate
// 控制下拉刷新时  同时出发上拉的方法  ？？奇怪没有再库里看到这个控制项,没有办法只能自己控制下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float lengthForTriggerSVPullAction = scrollView.contentOffset.y;
    
    if (lengthForTriggerSVPullAction<= 50)
    {
        _tableView.infiniteScrollingView.enabled = NO;
    }
    else
    {
        _tableView.infiniteScrollingView.enabled = YES;
        _tableView.showsInfiniteScrolling = YES;
    }
    
}

#pragma mark --- 
- (void)cell:(IndexMainNPCSTableViewCell *)cell didSelectedUser:(LightNPC *)npc{

    [self openConversionWithNpc:npc];
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



@end
