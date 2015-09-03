//
//  LightServerContactViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightServerContactViewController.h"

@interface LightServerContactViewController ()

@end

@implementation LightServerContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Light服务协议";
    
    UIWebView *textWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    [self.view addSubview:textWeb];
    
    
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"Light服务协议" withExtension:@"rtf"];
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
