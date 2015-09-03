//
//  MsgMsgHeadView.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgMsgHeadView.h"

@interface MsgMsgHeadView ()

@end

@implementation MsgMsgHeadView

+ (instancetype)initFromNib
{
    NSArray *arr  = [[NSBundle mainBundle] loadNibNamed:@"MsgMsgHeadView" owner:self options:nil];
    
    return arr[0];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([_delegate respondsToSelector:@selector(msgMsgHeadDidClickedView:)]) {
        [_delegate msgMsgHeadDidClickedView:self];
    }
}

@end
