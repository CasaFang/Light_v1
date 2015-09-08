//
//  PwdChangeContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PwdChangeContentView.h"

@implementation PwdChangeContentView

+ (instancetype)initFromNib{
    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"PwdChangeContentView" owner:self options:nil];
    return arr[0];
}

- (IBAction)onClicked:(UIButton *)sender{

    if (sender.tag == 1) {
        
        _fistBtn.selected = !_fistBtn.selected;
        _nPwdTextField.secureTextEntry = _fistBtn.selected;
    }
    else if(sender.tag == 2){
    
        _secondBtn.selected = !_secondBtn.selected;
        _confirmPwdTextField.secureTextEntry = _secondBtn.selected;
    }
    else if (sender.tag == 3){
    
        if ([_delegate respondsToSelector:@selector(pwdChangeContentViewDidCompleted:)]) {
            [_delegate pwdChangeContentViewDidCompleted:self];
        }
    }

}




@end
