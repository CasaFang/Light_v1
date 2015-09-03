//
//  PhoneEditViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PhoneEditViewController.h"
#import "PhoneEditContentView.h"

@interface PhoneEditViewController ()

@end

@implementation PhoneEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改手机号";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    PhoneEditContentView *contentView = [PhoneEditContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

@end
