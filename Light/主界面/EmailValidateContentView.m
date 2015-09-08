//
//  EmailValidateContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EmailValidateContentView.h"

@implementation EmailValidateContentView

+ (instancetype)initFromNib{
    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"EmailValidateContentView" owner:self options:nil];
    return arr[0];
}

- (IBAction)onClicked:(id)sender{

    if ([_delegate respondsToSelector:@selector(emailValidateContentViewDidBinding:)]) {
        [_delegate emailValidateContentViewDidBinding:self];
    }
}
@end
