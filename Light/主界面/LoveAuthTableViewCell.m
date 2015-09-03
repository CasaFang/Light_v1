//
//  LoveAuthTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveAuthTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface LoveAuthTableViewCell ()

@property (weak , nonatomic) IBOutlet UIImageView *authImageView;
@property (weak , nonatomic) IBOutlet UILabel *title;
@property (weak , nonatomic) IBOutlet UILabel *contentLabel;
@property (weak , nonatomic) IBOutlet UILabel *briefLabel;

@end

@implementation LoveAuthTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)disPlayViewWith:(LightAuth *)auth
{
    [_authImageView setImageWithURL:[NSURL URLWithString:[auth.pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _title.text = auth.title;
    _contentLabel.text = auth.content;
    _briefLabel.text = @"120：123";
}

@end
