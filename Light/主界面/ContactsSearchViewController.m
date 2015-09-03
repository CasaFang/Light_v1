//
//  ContactsSearchViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "ContactsSearchViewController.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "LightUser+Friend.h"
#import "MsgContactsTableViewCell.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"
#import "ContactsDetailViewController.h"

static int TableViewRequestInterval = 10;

static NSString *const cellIdentifier = @"msgContactsTableCellIndentifier";

@interface ContactsSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    int pageNo;
    
    UISearchBar *searchBar;
    
    
}

@property (strong , nonatomic) UITableView  *contactsTableView;

@property (strong , nonatomic) NSMutableArray  *contactsArray;

@end

@implementation ContactsSearchViewController
@synthesize delegate;
@synthesize contactsTableView;
@synthesize contactsArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加好友";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    pageNo = 1;
    contactsArray = [NSMutableArray new];
    
    contactsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64)) style:UITableViewStylePlain];
    [self.view addSubview:contactsTableView];
    contactsTableView.delegate = self;
    contactsTableView.dataSource = self;
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, 44)];
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    searchBar.translucent = YES;
    
    searchBar.tintColor = LightDark;
    searchBar.barTintColor = LightColor(235, 235, 235);
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.clipsToBounds = YES;
     searchBar.placeholder = @"按LightID/手机号/邮箱搜索";

    [self.contactsTableView setTableHeaderView:searchBar];
    
    __weak typeof(self) weakSelf = self;
    
    [self.contactsTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf doRefresh];
    }];
    
    [self.contactsTableView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf loadMoreData];
    }];
    
    pageNo = 1;
    
//    [self.contactsTableView triggerPullToRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- back
-(void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  loadMore
- (void)loadMoreData{
    
    pageNo = pageNo+1;
    
    __weak typeof(self) weakSelf = self;
    
    [[LightUser new] searchUserWithKey:searchBar.text andPageSize:TableViewRequestInterval andPageNo:pageNo andBlock:^(BOOL isSuccess, NSArray *friends, NSError *error) {
        
        [weakSelf.contactsTableView.infiniteScrollingView stopAnimating];
        if (isSuccess) {
            
            [weakSelf.contactsArray addObjectsFromArray:friends];
            [weakSelf.contactsTableView reloadData];
            
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
    
    [[LightUser new] searchUserWithKey:searchBar.text andPageSize:TableViewRequestInterval andPageNo:pageNo andBlock:^(BOOL isSuccess, NSArray *friends, NSError *error) {
    
        if (isSuccess) {
            
            weakSelf.contactsArray = [friends mutableCopy];
            [weakSelf.contactsTableView reloadData];
            
        }
        else
        {
            
        }
        
        [weakSelf.contactsTableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:.5];
        
    }];
}


#pragma mark -- UITableView delegate and datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [MsgContactsTableViewCell initFromNib];
    }
    
    LightUser *user = [contactsArray objectAtIndex:indexPath.row];
    
    [cell disPlayCellWithUser:user];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LightUser *user = [contactsArray objectAtIndex:indexPath.row];
    
    ContactsDetailViewController *c = [ContactsDetailViewController new];
    c.user = user;
    [self.navigationController pushViewController:c animated:YES];
    
    
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
    return contactsArray.count;
    
}
#pragma mark -- scroll delegate
// 控制下拉刷新时  同时出发上拉的方法  ？？奇怪没有再库里看到这个控制项,没有办法只能自己控制下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float lengthForTriggerSVPullAction = scrollView.contentOffset.y;
    
    if (lengthForTriggerSVPullAction<= 50)
    {
        contactsTableView.infiniteScrollingView.enabled = NO;
    }
    else
    {
        contactsTableView.infiniteScrollingView.enabled = YES;
        contactsTableView.showsInfiniteScrolling = YES;
    }
    
}


#pragma mark -- searchBar deleagte
- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [searchBar resignFirstResponder];
    [contactsTableView triggerPullToRefresh];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    contactsArray = [NSMutableArray new];
    [contactsTableView reloadData];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)_searchBar
{
    searchBar.showsCancelButton = NO;
}
@end
