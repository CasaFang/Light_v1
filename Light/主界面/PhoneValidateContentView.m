//
//  PhoneValidateContentView.m
//  Light
//
//  Created by FLYing on 15/9/9.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PhoneValidateContentView.h"

@implementation PhoneValidateContentView


+ (instancetype)initFromNib{
    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"PhoneValidateContentView" owner:self options:nil];
    return arr[0];
}

- (IBAction)onClicked:(id)sender{
    
    if ([_delegate respondsToSelector:@selector(phoneValidateContentViewDidBinding:)]) {
        [_delegate phoneValidateContentViewDidBinding:self];
    }
}

@end
