//
//  EditNickNameViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EditNickNameViewController.h"
#import "EditNickNameContentView.h"
#import "LightUser+Change.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"

@interface EditNickNameViewController ()
{

    EditNickNameContentView *contentView;
}

@end

@implementation EditNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改签名";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem  = rightItem;
    
    contentView.textField.text = _nickName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    
    
    contentView = [EditNickNameContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save:(id)sender
{
    [self.view showHudWithText:@"请稍等..."];
    
    [[LightMyShareManager shareUser].owner changeNameWithNewName:contentView.textField.text andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hideHud];
        if (isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            
            [self.view showTipAlertWithContent:error.domain];
        }
    }];
}


@end
