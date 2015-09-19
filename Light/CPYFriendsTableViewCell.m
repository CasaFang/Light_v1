//
//  CPYFriendsTableViewCell.m
//  Light
//
//  Created by ming on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYFriendsTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation CPYFriendsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"CPYFriendsTableViewCell" owner:self options:nil];
    return arr[0];
}

- (void)displayCellWithRelativeExperts:(LightRelativeExperts *)expert{
    
    [_avatarImageView setImageWithURL:[NSURL URLWithString:[expert.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _nameLabel.text = expert.name;
    _contentLabel.text = expert.pDescription;
}

@end
