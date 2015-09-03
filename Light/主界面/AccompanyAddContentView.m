//
//  AccompanyAddContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccompanyAddContentView.h"


@interface AccompanyAddContentView ()


@property (weak , nonatomic) IBOutlet UILabel *self_tagLabel;
@property (weak , nonatomic) IBOutlet UILabel *target_tagLabel;
@property (weak , nonatomic) IBOutlet UILabel *briefLabel;
@property (weak , nonatomic) IBOutlet UILabel *avatarLabel;

- (IBAction)onClicked:(UIControl *)sender;

@end

@implementation AccompanyAddContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"AccompanyAddContentView" owner:self options:nil];
    return [arr firstObject];
}


- (void)displayWithAccompany:(LightAccompany *)accompany{

    if (accompany.self_tag) {
        _self_tagLabel.text = @"已绑定";
    }
    else{
        _self_tagLabel.text = @"未绑定";
    }
    if (accompany.target_tag) {
        _target_tagLabel.text = @"已绑定";
    }
    else{
        _target_tagLabel.text = @"未绑定";
    }
    if (accompany.avatar||accompany.selectedImage) {
        
        _avatarLabel.text = @"已绑定";
    }
    else{
        _avatarLabel.text = @"未绑定";
    }
    if (accompany.brief) {
        
        _briefLabel.text = @"已绑定";
    }
    else{
        _briefLabel.text = @"未绑定";
    }
}

- (void)onClicked:(UIControl *)sender{

    if ([_delegate respondsToSelector:@selector(accompantAddcontentView:didSelectedIndex:)]) {
        [_delegate accompantAddcontentView:self didSelectedIndex:(int)sender.tag];
    }
}
@end
