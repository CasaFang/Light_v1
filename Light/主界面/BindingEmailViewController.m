//
//  BindingEmailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "BindingEmailViewController.h"
#import "BindingEmailContentView.h"
#import "EmailEditViewController.h"

@interface BindingEmailViewController ()

@end

@implementation BindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"绑定邮箱";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edit:(UIButton *)btn{
    
    EmailEditViewController *c =[EmailEditViewController new];
    [self.navigationController pushViewController:c  animated:YES];
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    BindingEmailContentView *contentView = [BindingEmailContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

@end
