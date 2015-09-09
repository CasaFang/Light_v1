//
//  IndexAccountContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAccountContentView.h"
#import "BindingEmailContentView.h"
#import "BindingPhoneContentView.h"

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

- (void)displayViewUser:(LightUser *)user{

    if (user.phone) {
        
        _phoneLabel.text = user.phone;
        
    }
    else {
    
        _phoneLabel.text=  @"未绑定";
    }
    
    if (user.email) {
        
        _emailLabel.text = user.email;
        
    }
    else {
        
        _emailLabel.text=  @"未绑定";
    }
}

@end
