//
//  CPYMinLiContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYMinLiContentView.h"

@interface CPYMinLiContentView ()

@property (weak , nonatomic) IBOutlet UIImageView *headImageView;

- (IBAction)onBtnClicked:(UIButton *)sender;

@end

@implementation CPYMinLiContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"CPYMinLiContentView" owner:self options:nil];
    return arr[0];
}

- (void)onBtnClicked:(UIButton *)sender{

    if ([_delegate respondsToSelector:@selector(minliContentView:didSelectedBtnIndex:)]) {
        [_delegate minliContentView:self didSelectedBtnIndex:sender.tag];
    }
}


@end
