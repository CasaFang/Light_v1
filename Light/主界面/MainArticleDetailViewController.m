//
//  MainArticleDetailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MainArticleDetailViewController.h"
#import "MainArticleDetailContentView.h"

@interface MainArticleDetailViewController ()<MainArticleDetailContentViewDelegate>
{
    MainArticleDetailContentView *contentView;
}

@end

@implementation MainArticleDetailViewController
@synthesize  article;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self buildUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [contentView displayContentView:article];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, WINSIZE.width, WINSIZE.height)];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [MainArticleDetailContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    f.size.height = [MainArticleDetailContentView heightForContentViewWithArticle:article];
    contentView.frame = f;
   
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


#pragma mark -- delegate
- (void)articleDetailContentViewDidBack:(MainArticleDetailContentView *)v{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//打赏
- (void)articleDetailContentViewDidGeiMoney:(MainArticleDetailContentView *)v{


}

@end
