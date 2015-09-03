//
//  IndexSettingContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexSettingContentView.h"

@implementation IndexSettingContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexSettingContentView" owner:self options:nil];
    return arr[0];
}

- (void)onClicked:(UIControl *)sender
{
    if ([_delegate respondsToSelector:@selector(settingContentView:didSelectedSection:)]) {
        [_delegate settingContentView:self didSelectedSection:sender.tag];
    }
}
@end
