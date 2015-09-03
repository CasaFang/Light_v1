//
//  QiuHun2ViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "QiuHun2ViewController.h"
#import "QiuHun2ContentView.h"
#import "UIView+Hud.h"
#import "LightUser+Marry.h"

@interface QiuHun2ViewController ()<QiuHun2ContentViewDelegate,UIAlertViewDelegate>

{
    QiuHun2ContentView *qiuHun2ContentView;
}
@end

@implementation QiuHun2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"2/2";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(next:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)next:(UIButton *)btn{
    
    NSString *content = qiuHun2ContentView.contentTextView.text;
    
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithText:@"请稍等..."];
    
    [[LightUser new] marryToUser:_selectedUser.Id andContent:content andCompletedBlock:^(BOOL isSuccess, NSError *error) {
       
        [weakSelf.view hideHud];
        
        if (isSuccess) {
            
            UIAlertView *alert = [self.view  showTipAlertWithContent:@"邀请函发送成功!您的邀请对象同意后会通知您!同时系统管理员也会联系您"];
            alert.delegate = self;
        }
        else{
        
            [weakSelf.view showTipAlertWithContent:error.domain];
        }
    }];

}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    container.backgroundColor = LightColor(230, 230, 230);
    [self.view addSubview:container];
    
    qiuHun2ContentView = [QiuHun2ContentView initFromNib];
    
    CGRect f = qiuHun2ContentView.frame;
    f.size.width = WINSIZE.width;
    qiuHun2ContentView.frame = f;
    
    qiuHun2ContentView.delegate = self;
    [container addSubview:qiuHun2ContentView];
    container.contentSize = qiuHun2ContentView.frame.size;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
