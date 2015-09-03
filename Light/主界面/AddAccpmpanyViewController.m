//
//  AddAccpmpanyViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AddAccpmpanyViewController.h"
#import "AccompanyAddContentView.h"
#import "AccompanyUploadImageViewController.h"
#import "LightAccompany.h"
#import "AccompanyTagViewController.h"
#import "AccompanyBriefViewController.h"
#import "UIView+Hud.h"

@interface AddAccpmpanyViewController ()<AccompanyAddContentViewDelegate,AccompanyUploadImageViewControllerDelegate,AccompanyTagViewControllerDelegate,AccompanyBriefViewControllerDelegate>
{

    AccompanyAddContentView *contentView;
    
    LightAccompany *accompany;
}
@end

@implementation AddAccpmpanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"需要人陪";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    accompany = [LightAccompany new];
    
    [self buildUI];
}

- (void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI{

    UIScrollView *containerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height -64)];
    [self.view addSubview:containerScroll];
    
    contentView = [AccompanyAddContentView initFromNib];
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame.size.width = WINSIZE.width;
    contentView.frame = contentViewFrame;
    contentView.delegate = self;
    [containerScroll addSubview:contentView];
    containerScroll.contentSize = CGSizeMake(0, contentView.frame.size.height);
    
    
}

#pragma mark --AccompanyAddContentViewDelegate
- (void)accompantAddcontentView:(AccompanyAddContentView *)v didSelectedIndex:(int)index{

    switch (index) {
        case 0:
        {
            AccompanyTagViewController *c = [AccompanyTagViewController new];
            c.tagStr = accompany.self_tag;
            c.isSelfTag = YES;
            c.delegate = self;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 1:
        {
            AccompanyTagViewController *c = [AccompanyTagViewController new];
            c.tagStr = accompany.target_tag;
            c.isSelfTag = NO;
            c.delegate = self;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 2:
        {
            AccompanyUploadImageViewController *c  = [AccompanyUploadImageViewController new];
            c.delegate = self;
            c.accompany = accompany;
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 3:
        {
            AccompanyBriefViewController *c  =[AccompanyBriefViewController new];
            c.brief = accompany.brief;
            c.delegate = self;
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 4:
        {
            // 保存
            
            [self.view showHudWithText:@"正在上传..."];
            [accompany saveWithBlock:^(BOOL isSuccess, NSError *error) {
                
                [self.view hideHud];
                if (isSuccess) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                
                    [self.view showTipAlertWithContent:error.domain];
                }
            }];
        }
            break;
    }

}


#pragma mark -- AccompanyUploadImageViewControllerDelegate
- (void)accompanyUploadImageViewController:(AccompanyUploadImageViewController *)c didSelectedImage:(UIImage *)image{

    [self.navigationController popViewControllerAnimated:YES];
    
    if (image) {
        
        accompany.selectedImage = image;
        
        [contentView displayWithAccompany:accompany];
        
     }
}

#pragma mark --AccompanyTagViewControllerDelegate
-(void)accompanyTagViewController:(AccompanyTagViewController *)c didSeletedTag:(NSString *)tag{

    [self.navigationController popViewControllerAnimated:YES];
    if (c.isSelfTag) {
        accompany.self_tag = tag;
    }
    else{
    
        accompany.target_tag = tag;
    }
    
    [contentView displayWithAccompany:accompany];
}

#pragma mark -- AccompanyBriefViewControllerDelegate
- (void)AccompanyBriefViewController:(AccompanyBriefViewController *)c didSeletedBrief:(NSString *)brief
{
    [self.navigationController popViewControllerAnimated:YES];
    
    accompany.brief = brief;
    [contentView displayWithAccompany:accompany];
}
@end
