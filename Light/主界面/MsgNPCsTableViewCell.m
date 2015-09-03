//
//  MsgNPCsTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgNPCsTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation MsgNPCsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MsgNPCsTableViewCell" owner:self options:nil];
    return arr[0];
}

- (void)displayCellWithNPC:(LightNPC *)npc{
    
    [_avatarImageView setImageWithURL:[NSURL URLWithString:[npc.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _nameLabel.text = npc.name;
    _contentLabel.text = npc.welcomeWord;
}


@end
