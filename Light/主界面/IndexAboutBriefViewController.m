//
//  IndexAboutBriefViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAboutBriefViewController.h"
#import "AboutBriefContentView.h"

@interface IndexAboutBriefViewController ()

@end

@implementation IndexAboutBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于 Light";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIWebView *textWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    [self.view addSubview:textWeb];
    
    
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"Light 关于" withExtension:@"rtf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [textWeb loadRequest:request];

}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    AboutBriefContentView *contentView = [AboutBriefContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
