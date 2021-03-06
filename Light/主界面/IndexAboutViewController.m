//
//  IndexAboutViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAboutViewController.h"
#import "AppDelegate.h"
#import "IndexAboutContentView.h"
#import "IndexAboutBriefViewController.h"
#import "IndexAboutDonationViewController.h"

@interface IndexAboutViewController ()<IndexAboutContentViewDelegate>

@end

@implementation IndexAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --actions
- (void)backToMain:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRevealController];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
     container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    IndexAboutContentView *contentView = [IndexAboutContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


- (void)aboutContentView:(IndexAboutContentView *)v didSelectedSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            IndexAboutBriefViewController *c = [IndexAboutBriefViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
            IndexAboutDonationViewController *c = [IndexAboutDonationViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
    }
}


@end
