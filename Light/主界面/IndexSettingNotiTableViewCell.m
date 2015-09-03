//
//  IndexSettingNotiTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexSettingNotiTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation IndexSettingNotiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexSettingNotiTableViewCell" owner:self options:nil];
    return arr[0];
}

- (void)displayCellWithNoti:(LightNoti *)noti{
    
//    [_avatarImageView setImageWithURL:[NSURL URLWithString:[expert.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _nameLabel.text = expert.name;
//    _contentLabel.text = expert.brief;
}

@end
