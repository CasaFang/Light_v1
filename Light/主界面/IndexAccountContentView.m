//
//  IndexAccountContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAccountContentView.h"
#import "NSString+Extention.h"

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
    
    if (user.phone.trimWhiteSpace) {
        
        _phoneLabel.text = user.phone.trimWhiteSpace;
        
    }
    else {
    
        _phoneLabel.text=  @"未绑定";
    }
    
    if (user.email.trimWhiteSpace) {
        
        _emailLabel.text = user.email.trimWhiteSpace;
        
    }
    else {
        
        _emailLabel.text=  @"未绑定";
    }
}

@end
