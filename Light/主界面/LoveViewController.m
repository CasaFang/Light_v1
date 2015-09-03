//
//  LoveViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveViewController.h"
#import "LoveContentView.h"
#import "LoveQiuHunViewController.h"
#import "LoveAuthTableViewController.h"
#import "LoveMarryViewController.h"

@interface LoveViewController ()<LoveContentViewDelegate>

@end

@implementation LoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"求爱";
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- actions

- (void)buildUI{

    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64+49))];
    container.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:container];
    
    LoveContentView *loveContentView = [LoveContentView initFromNib];
    
    CGRect f = loveContentView.frame;
    f.size.width = WINSIZE.width;
    loveContentView.frame = f;
    
    loveContentView.delegate = self;
    [container addSubview:loveContentView];
    container.contentSize = loveContentView.frame.size;
}

#pragma mark -- loveContentView delegate
- (void)loveContentView:(LoveContentView *)v didSelectedSection:(NSInteger)section
{
    switch (section) {
            
        case 0:
        {
            LoveQiuHunViewController *c = [LoveQiuHunViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 1:
        {
            LoveAuthTableViewController *c = [LoveAuthTableViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;

        case 2:
        {
            LoveMarryViewController *c = [LoveMarryViewController new];
            c.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;

    }
}

@end
