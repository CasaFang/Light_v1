//
//  LoveQiuHunViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveQiuHunViewController.h"
#import "LoveQiuHunContentView.h"
#import "QiuHun1ViewController.h"

@interface LoveQiuHunViewController ()<LoveQiuHunContentViewDelegate>

@end

@implementation LoveQiuHunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"求爱";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:container];
    
    LoveQiuHunContentView *loveContentView = [LoveQiuHunContentView initFromNib];
    
    CGRect f = loveContentView.frame;
    f.size.width = WINSIZE.width;
    loveContentView.frame = f;
    
    loveContentView.delegate = self;
    [container addSubview:loveContentView];
    container.contentSize = loveContentView.frame.size;
}


#pragma mark -- marry

- (void)loveQiuHunContentViewDidQiuHun:(LoveQiuHunContentView *)v{

    QiuHun1ViewController *c = [QiuHun1ViewController new];
    [self.navigationController pushViewController:c animated:YES];
}
@end
