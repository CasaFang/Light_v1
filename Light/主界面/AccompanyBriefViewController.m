//
//  AccompanyBriefViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccompanyBriefViewController.h"
#import "AccompanyBriefContentView.h"
#import "NSString+Extention.h"

@interface AccompanyBriefViewController ()
{
    AccompanyBriefContentView *contentView;
}

@end

@implementation AccompanyBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改标签";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    [self buildUI];
    
    contentView.briefTextView.text = _brief;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(UIButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(AccompanyBriefViewController:didSeletedBrief:)]) {
        [_delegate AccompanyBriefViewController:self didSeletedBrief:[contentView.briefTextView.text trimWhiteSpace]];
    }
}
- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)buildUI{
    
    UIScrollView *containerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height -64)];
    containerScroll.backgroundColor = LightColor(220, 220, 220);
    [self.view addSubview:containerScroll];
    
    contentView = [AccompanyBriefContentView initFromNib];
    
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame.size.width = WINSIZE.width;
    contentView.frame = contentViewFrame;
    [containerScroll addSubview:contentView];
    containerScroll.contentSize = CGSizeMake(0, contentView.frame.size.height);
    
    
}


@end
