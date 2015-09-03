//
//  CPYContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYContentView.h"

@interface CPYContentView ()

- (IBAction)onClicked:(UIControl *)sender;

@end

@implementation CPYContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"CPYContentView" owner:self options:nil];
    return arr[0];
}

- (void)onClicked:(UIControl *)sender
{
    
    if ([_delegate respondsToSelector:@selector(cpyContentView:didSelectedSectionIndex:)]) {
        [_delegate cpyContentView:self didSelectedSectionIndex:sender.tag];
    }
}
@end
