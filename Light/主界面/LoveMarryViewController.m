//
//  LoveMarryViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveMarryViewController.h"

@interface LoveMarryViewController ()

@end

@implementation LoveMarryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"海外结婚";
    
    UIWebView *textWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    [self.view addSubview:textWeb];
    
    
    NSURL *rtfUrl = [NSURL URLWithString:@"http://wedding.lightlgbt.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [textWeb loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
