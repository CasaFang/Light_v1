//
//  LoveContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveContentView.h"

@interface LoveContentView ()

- (IBAction)onClicked:(UIControl *)sender;

@end

@implementation LoveContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}

- (void)onClicked:(UIControl *)sender
{
    if ([_delegate respondsToSelector:@selector(loveContentView:didSelectedSection:)]) {
        [_delegate loveContentView:self didSelectedSection:sender.tag];
    }
    
}

@end
