//
//  QiuHun1ContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "QiuHun1ContentView.h"

@implementation QiuHun1ContentView


+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"QiuHun1ContentView" owner:self options:nil];
    return arr[0];
}
- (void)onCLIcKedSelectUser:(id)sender{

    if ([_delegate respondsToSelector:@selector(qiuHun1ContentViewDidClickedSelectedUser:)]) {
        [_delegate qiuHun1ContentViewDidClickedSelectedUser:self];
    }
}

@end
