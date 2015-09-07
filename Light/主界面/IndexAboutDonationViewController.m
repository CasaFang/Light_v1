//
//  IndexAboutDonationViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAboutDonationViewController.h"
#import "DonationView.h"

@interface IndexAboutDonationViewController ()<DonationViewDelegate>

@end

@implementation IndexAboutDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"捐助";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
     container.backgroundColor = LightColor(244, 244, 244);
    container.alwaysBounceVertical = YES;
    
    
    DonationView *contentView = [DonationView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


@end
