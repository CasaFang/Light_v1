//
//  NeedPeopleDetailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NeedPeopleDetailViewController.h"
#import "NeedPeopleDetailContentView.h"
#import <RongIMKit/RongIMKit.h>

@interface NeedPeopleDetailViewController ()<NeedPeopleDetailContentViewDelegate>
{

    NeedPeopleDetailContentView *contentView;
}

@end

@implementation NeedPeopleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _accompany.name;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
    
    [contentView displayViewWithAccompany:_accompany];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)buildUI{
    
    UIScrollView *containerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height -64)];
    [self.view addSubview:containerScroll];
    
    contentView = [NeedPeopleDetailContentView initFromNib];
    
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame.size.width = WINSIZE.width;
    contentViewFrame.size.height = [NeedPeopleDetailContentView heightForViewWithAccompany:_accompany ];
    contentView.frame = contentViewFrame;
    contentView.delegate = self;
    [containerScroll addSubview:contentView];
    containerScroll.contentSize = CGSizeMake(0, contentView.frame.size.height);
    
    
}

#pragma mark --NeedPeopleDetailContentViewDelegate
- (void)needPeopleDetailContentView:(NeedPeopleDetailContentView *)v didSelectedIndex:(int)index{

    switch (index) {
        case 0:
        {
            RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
            conversationVC.conversationType = ConversationType_PRIVATE;
            conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)_accompany.user_id];
            conversationVC.userName =  _accompany.name;
            conversationVC.title = _accompany.name;
            [self.navigationController pushViewController:conversationVC animated:YES];
        
        }
            break;
            
        default:
            break;
    }
}


@end
