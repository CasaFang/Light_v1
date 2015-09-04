//
//  MarryCertificationViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryCertificationViewController.h"
#import "MarryCertificationContentView.h"

@interface MarryCertificationViewController ()<MarryCertificationContentViewDelegate>
{
    MarryCertificationContentView *contentView;
}

@end

@implementation MarryCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"邀请函";
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
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
    
    
    contentView = [MarryCertificationContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}



#pragma mark -- MarryCertificationContentViewDelegate
- (void)marryCertificationContentViewDidBack:(MarryCertificationContentView *)v{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
