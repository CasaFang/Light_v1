//
//  MarryInvitationContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryInvitationContentView.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface MarryInvitationContentView (){


}

@property (weak , nonatomic) IBOutlet UIButton *refusedBtn;
@property (weak , nonatomic) IBOutlet UILabel  *contentLabel;
@property (weak , nonatomic) IBOutlet UIImageView *marryerAvatar;
@property (weak , nonatomic) IBOutlet UIImageView *marryedAvatar;

@end

@implementation MarryInvitationContentView

- (void)awakeFromNib{

    _refusedBtn.layer.borderColor = LightColor(0, 157, 212).CGColor;
    _refusedBtn.layer.borderWidth = 1.0f;
    _contentLabel.layer.cornerRadius = 5.0f;
    _contentLabel.clipsToBounds = YES;
//    _contentLabel.shadowOffset = CGSizeMake(1, 1);
//    _contentLabel.shadowColor = [UIColor grayColor];
    
}
+ (instancetype)initFromNib{

    return [[[NSBundle mainBundle] loadNibNamed:@"MarryInvitationContentView" owner:self options:nil] firstObject];
}

- (void)displayWithNoti:(LightNoti *)noti{

    LightMarry *marry = noti.notiObject;
    [_marryedAvatar setImageWithURL:[NSURL URLWithString:marry.marryedAvatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_marryerAvatar setImageWithURL:[NSURL URLWithString:marry.marryerAvatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _contentLabel.text = [NSString stringWithFormat:@"%@像你发出了结婚请求",marry.marryerName];
}

- (IBAction)onClicked:(UIButton *)sender{

    if (sender.tag == 0) {
        
        if ([_delegate respondsToSelector:@selector(marryInvitationContentViewDidAgreed:)]) {
            [_delegate marryInvitationContentViewDidAgreed:self];
        }
    }
    else if (sender.tag == 1){
    
    
        if ([_delegate respondsToSelector:@selector(marryInvitationContentViewDidRefused:)]) {
            [_delegate marryInvitationContentViewDidRefused:self];
        }
    }
}

@end
