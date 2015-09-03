//
//  AvatarEditContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AvatarEditContentView.h"

@implementation AvatarEditContentView

- (IBAction)onClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(avatarEditContentViewDidClickedEditAvatar:)]) {
        [_delegate avatarEditContentViewDidClickedEditAvatar:self];
    }
}

+ (instancetype)initFromNib{

    return [[[NSBundle mainBundle]loadNibNamed:@"AvatarEditContentView" owner:self options:nil] firstObject];
}
@end
