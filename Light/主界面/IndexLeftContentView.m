//
//  IndexLeftContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftContentView.h"
#import "LightMyShareManager.h"
#import "LightUser.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface IndexLeftContentView ()

@property (weak , nonatomic) IBOutlet UIImageView *headBgImageView;

- (IBAction)onClicked:(UIControl *)sender;

@end

@implementation IndexLeftContentView


+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}
- (void)awakeFromNib
{
    [self disPlayView];
    [self sendSubviewToBack:_headBgImageView];
}

- (void)onClicked:(UIControl *)sender
{
    if ([_delegate respondsToSelector:@selector(contentView:didSelectedSection:)]) {
        [_delegate contentView:self didSelectedSection:sender.tag];
    }
}
- (UIImage *)avatarImage{

    return _avatarImageView.image;
}
- (void)disPlayView
{
    LightUser *user = [LightMyShareManager shareUser].owner;
    [_avatarImageView setImageWithURL:[NSURL URLWithString:[user.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _nameLabel.text = user.name;
}


@end
