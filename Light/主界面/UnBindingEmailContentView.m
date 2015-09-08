//
//  BindingEmailContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "UnBindingEmailContentView.h"

@implementation UnBindingEmailContentView

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"UnBindingEmailContentView" owner:self options:nil];
    return arr[0];
}

- (IBAction)onClicked:(id)sender{

    if ([_delegate respondsToSelector:@selector(unBindingEmailContentViewDidUnbindingEmail:)]) {
        [_delegate unBindingEmailContentViewDidUnbindingEmail:self];
    }
}
@end
