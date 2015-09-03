//
//  LoveQiuHunContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveQiuHunContentView.h"

@implementation LoveQiuHunContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"LoveQiuHunContentView" owner:self options:nil];
    return arr[0];
}

- (void)onQiuHun:(id)sender{

    if ([_delegate respondsToSelector:@selector(loveQiuHunContentViewDidQiuHun:)]) {
        [_delegate loveQiuHunContentViewDidQiuHun:self];
    }
}

@end
