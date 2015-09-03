//
//  LightTableViewController.m
//  
//
//  Created by FLY on 15/6/15.
//
//

#import "LightTableViewController.h"

@interface LightTableViewController ()

@end

@implementation LightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, 1.0f, 20.0f);
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell layoutSubviews];
}

@end
