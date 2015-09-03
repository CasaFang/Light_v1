//
//  IndexAccountContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAccountContentView.h"

@implementation IndexAccountContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexAccountContentView" owner:self options:nil];
    return arr[0];
}

- (void)onClicked:(UIControl *)sender
{
    if ([_delegate respondsToSelector:@selector(accountContentView:didSelectedSection:)]) {
        [_delegate accountContentView:self didSelectedSection:sender.tag];
    }
}

@end
