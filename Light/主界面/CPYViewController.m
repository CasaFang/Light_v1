//
//  CPYViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYViewController.h"
#import "CPYContentView.h"
#import "CPYAccompanyTableViewController.h"
#import "CPYCounselorTableViewController.h"
#import "CPYMinLiViewController.h"
#import "CPYLawyerTableViewController.h"
#import "CPYNeedPeopleTableViewController.h"
#import "CPYMingLiTaLuoTableViewController.h"

@interface CPYViewController ()<CPYContentViewDelegate>

@end

@implementation CPYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title = @"求同";
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- actions
- (void)buildUI{

    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64+49))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    CPYContentView *contentView = [CPYContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
     container.contentSize = contentView.frame.size;
}


#pragma mark -- cpyContentView Delegate

- (void)cpyContentView:(CPYContentView *)v didSelectedSectionIndex:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            CPYNeedPeopleTableViewController *c = [CPYNeedPeopleTableViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 1:
        {
            CPYAccompanyTableViewController *c = [CPYAccompanyTableViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 2:
        {
            CPYCounselorTableViewController *c = [CPYCounselorTableViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 3:
        {
            // 一起暂时用这个替代
            
            CPYMingLiTaLuoTableViewController *c = [CPYMingLiTaLuoTableViewController  new];
//            CPYMinLiViewController *c = [CPYMinLiViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 4:
        {
            CPYLawyerTableViewController *c = [CPYLawyerTableViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
            
    }
}

@end
