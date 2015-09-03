//
//  MsgContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgHeadTabView.h"


@interface MsgHeadTabView ()

@property (weak , nonatomic) IBOutlet UIButton *msgBtn;
@property (weak , nonatomic) IBOutlet UIImageView  *msgTip;

@property (weak , nonatomic) IBOutlet UIButton *contactsBtn;
@property (weak , nonatomic) IBOutlet UIImageView  *contactsTip;

@property (assign , readwrite, nonatomic) int currentSelectedIndex;

- (IBAction)onMsgBtnClicked:(UIButton *)sender;
- (IBAction)onContactBtnClicked:(UIButton *)sender;



@end
@implementation MsgHeadTabView

+ (instancetype)initFromNib
{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}

- (void)setSelectedIndex:(int)index
{
    if (index == 0) {
        
        [self onMsgBtnClicked:_msgBtn];
    }
    else
    {
        [self onContactBtnClicked:_contactsBtn];
    }
}

#pragma mark -- actions
- (void)onContactBtnClicked:(UIButton *)sender
{
    if (_contactsBtn.selected) {
        
        return;
    }
    _contactsBtn.selected = YES;
    _contactsTip.hidden = NO;
    _msgBtn.selected = NO;
    _msgTip.hidden = YES;
    _currentSelectedIndex = 1;
    
    if ([_delegate respondsToSelector:@selector(didSelectedContactsTab:)]) {
        [_delegate didSelectedContactsTab:self];
    }
}
- (void)onMsgBtnClicked:(UIButton *)sender
{
    if (_msgBtn.selected) {
        
        return;
    }
    _msgBtn.selected = YES;
    _msgTip.hidden = NO;
    _contactsBtn.selected = NO;
    _contactsTip.hidden = YES;
    _currentSelectedIndex = 0;
    
    if ([_delegate respondsToSelector:@selector(didSelectedMsgTab:)]) {
        [_delegate didSelectedMsgTab:self];
    }
}


@end
