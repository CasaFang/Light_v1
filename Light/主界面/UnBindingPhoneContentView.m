//
//  BindingPhoneContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "UnBindingPhoneContentView.h"

@implementation UnBindingPhoneContentView

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"UnBindingPhoneContentView" owner:self options:nil];
    return arr[0];
}

- (IBAction)onClicked:(id)sender{

//    if (_phoneTextField.text) {
        
        if ([_delegate respondsToSelector:@selector(unbindingPhoneContentViewDidUnbinding:)]) {
            [_delegate unbindingPhoneContentViewDidUnbinding:self];
        }
//    }
}
@end
