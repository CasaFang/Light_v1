//
//  IndexAccountViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAccountViewController.h"
#import "AppDelegate.h"
#import "IndexAccountContentView.h"
#import "PwdChangeViewController.h"
#import "BindingEmailViewController.h"
#import "BindingPhoneViewController.h"

@interface IndexAccountViewController ()<IndexAccountContentViewDelegate>

@end

@implementation IndexAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户";
    
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
    
    
    IndexAccountContentView *contentView = [IndexAccountContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --
- (void)accountContentView:(IndexAccountContentView *)v didSelectedSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            BindingPhoneViewController *c = [BindingPhoneViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
            BindingEmailViewController *c = [BindingEmailViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 2:
        {
            PwdChangeViewController *c = [PwdChangeViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 3:
        {
            // 支付宝
        }
            break;

    }
}
@end
