//
//  NeedPeopleDetailContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NeedPeopleDetailContentView.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>


@interface NeedPeopleDetailContentView ()


@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *self_tagLabel;
@property (weak , nonatomic) IBOutlet UILabel     *target_tagLabel;
@property (weak , nonatomic) IBOutlet UIImageView *picImageView;
@property (weak , nonatomic) IBOutlet UILabel     *contentLabel;

- (IBAction)onClicked:(UIControl *)sender;

 @end

@implementation NeedPeopleDetailContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"NeedPeopleDetailContentView" owner:self options:nil];
    return [arr firstObject];
}

- (void)displayViewWithAccompany:(LightAccompany *)accompany{
    
    [_avatarImageView setImageWithURL:[NSURL URLWithString:accompany.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_picImageView setImageWithURL:[NSURL URLWithString:accompany.picture] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _self_tagLabel.text = accompany.self_tag;
    _target_tagLabel.text = accompany.target_tag;
    _contentLabel.text = accompany.brief;

}

+ (CGFloat)heightForViewWithAccompany:(LightAccompany *)accompany{

    CGFloat otherHeight = 402;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    
    CGSize sizeToFit = [accompany.brief  sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0] constrainedToSize:CGSizeMake(300/320.0*WINSIZE.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (sizeToFit.width == 0)
    {
        sizeToFit = CGSizeZero;
    }
#pragma clang diagnostic pop
    return sizeToFit.height+otherHeight;
}


- (void)onClicked:(UIControl *)sender{

    if ([_delegate respondsToSelector:@selector(needPeopleDetailContentView:didSelectedIndex:)]) {
        [_delegate needPeopleDetailContentView:self didSelectedIndex:(int)sender.tag];
    }
}

@end
