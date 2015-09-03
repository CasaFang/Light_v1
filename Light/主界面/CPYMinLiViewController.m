//
//  CPYMinLiViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYMinLiViewController.h"
#import "CPYMinLiContentView.h"
#import "CPYMinLiLGBTViewController.h"
#import "CPYMingLiBaZiTableViewController.h"
#import "CPYMingLiTaLuoTableViewController.h"
#import "CPYMingLiXingZuoViewController.h"

@interface CPYMinLiViewController ()<CPYMinLiContentViewDelegate>

@end

@implementation CPYMinLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"命理灵疗";
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    CPYMinLiContentView *contentView = [CPYMinLiContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


#pragma mark -- cpyContentView Delegate
- (void)minliContentView:(CPYMinLiContentView *)v didSelectedBtnIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            CPYMingLiBaZiTableViewController *c = [CPYMingLiBaZiTableViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            CPYMingLiXingZuoViewController *c = [CPYMingLiXingZuoViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 3:
        {
            CPYMingLiTaLuoTableViewController *c = [CPYMingLiTaLuoTableViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 4:
        {
            CPYMinLiLGBTViewController *c = [CPYMinLiLGBTViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
    }


}
@end
