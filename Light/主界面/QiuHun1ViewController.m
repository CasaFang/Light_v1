//
//  QiuHun1ViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "QiuHun1ViewController.h"
#import "QiuHun1ContentView.h"
#import "ContactsTableViewController.h"
#import "QiuHun2ViewController.h"
#import "LightUser.h"
#import "LightNavigationController.h"

@interface QiuHun1ViewController ()<QiuHun1ContentViewDelegate,ContactsTableViewControllerDelegate>
{
    QiuHun1ContentView *qiuHun1ContentView;
    LightUser *selectedUser;
}
@end

@implementation QiuHun1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"1/2";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStyleDone target:self action:@selector(next:)];
    
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
    
    QiuHun2ViewController *c = [QiuHun2ViewController new];
    c.selectedUser = selectedUser;
    [self.navigationController pushViewController:c animated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:container];
    
    qiuHun1ContentView = [QiuHun1ContentView initFromNib];
    
    CGRect f = qiuHun1ContentView.frame;
    f.size.width = WINSIZE.width;
    qiuHun1ContentView.frame = f;
    
    qiuHun1ContentView.delegate = self;
    [container addSubview:qiuHun1ContentView];
    container.contentSize = qiuHun1ContentView.frame.size;
}


#pragma mark -- 

- (void)qiuHun1ContentViewDidClickedSelectedUser:(QiuHun1ContentView *)v{
    ContactsTableViewController *contacts = [ContactsTableViewController new];
    contacts.delegate  =self;
    LightNavigationController *navi = [[LightNavigationController alloc]initWithRootViewController:contacts];
    
    [self presentViewController:navi animated:YES completion:^{
        
        [contacts hideLeftCancleBtn:NO];
    }];

}


- (void)contacts:(ContactsTableViewController *)contact didSelectedUser:(LightUser *)user{
    
    selectedUser = user;
    [self dismissViewControllerAnimated:YES completion:^{
        
         qiuHun1ContentView.nameLabel.text = user.name;
    }];
   
    
}
@end
