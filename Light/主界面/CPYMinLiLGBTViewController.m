//
//  CPYMinLiLGBTViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYMinLiLGBTViewController.h"

@interface CPYMinLiLGBTViewController ()

@end

@implementation CPYMinLiLGBTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"命理为什么适用于LGBT";
    
    UIWebView *textWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    [self.view addSubview:textWeb];
    
    
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"命理为什么适用于LGBT" withExtension:@"rtf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [textWeb loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
