//
//  AddrSelectTableViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AddrSelectTableViewController.h"
#import "KDHeaderView.h"
#import "LightAddress.h"

@interface AddrSelectTableViewController ()<KDHeaderViewDelegate>
{
    NSInteger  lastSelectedSection;
    NSMutableArray *mutalbeOriArray;
}

@property (strong , nonatomic) NSArray *addressArr;

@end

@implementation AddrSelectTableViewController
@synthesize addressArr,selectedAddressDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [[LightAddress new] getAllAddressWithBlock:^(BOOL isSuccess, LightAddress *address, NSError *error) {
       
        addressArr = address.addressArray;
        mutalbeOriArray = [address.addressArray mutableCopy];
        [self.tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- uitableview delegate and datesource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = [[[addressArr objectAtIndex:indexPath.section] valueForKey:@"City"] objectAtIndex:indexPath.row];
    
    if ([[dic valueForKey:@"-Code"] isEqualToString:[selectedAddressDic valueForKey:@"-Code"]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [dic valueForKey:@"-Name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KDHeaderView *head = [[KDHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, 40)];
    head.tag = section;
    head.delegate = self;
    [head setText:[[addressArr objectAtIndex:section] valueForKey:@"-Name"]];
    return head;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[addressArr[section] valueForKey:@"City"] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  addressArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [[addressArr[indexPath.section] valueForKey:@"City"] objectAtIndex:indexPath.row];
    
    NSString *city = [addressArr[indexPath.section] valueForKey:@"-Name"];
    NSString *town = dic[@"-Name"];
    
    NSString *selectedValue = [NSString stringWithFormat:@"中国 %@ %@",city,town];
    if ([_delegate respondsToSelector:@selector(addrSelectTableViewControllerDidSelectedAddr:)]) {
        [_delegate addrSelectTableViewControllerDidSelectedAddr:selectedValue];
    }
}

- (void)head:(KDHeaderView *)view didSelectedWithSection:(NSInteger)section
{
    
//    NSMutableArray *tem = [[mutalbeOriArray objectAtIndex:section] valueForKey:@"City"];
//    NSMutableDictionary *d = addressArr[section];
//    
//    // -1表示 没有选中展开的section
//    if (lastSelectedSection == -1) {
//        
//        [d setValue:tem forKey:@"City"];
//        
//        lastSelectedSection = section;
//        
//        [self.tableView reloadData];
//        
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
//    else
//    {
//        if (lastSelectedSection == section) {
//            
//            [d setValue:@[] forKey:@"City"];
//            lastSelectedSection = -1;
//            
//            [self.tableView reloadData];
//            
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        }
//        else
//        {
//            NSMutableDictionary *oldDic = addressArr[lastSelectedSection];
//            [oldDic setValue:@[] forKey:@"City"];
//            
//            [d setValue:tem forKey:@"City"];
//            
//            lastSelectedSection = section;
//            
//            [self.tableView reloadData];
//            
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        }
//    }
}



@end
