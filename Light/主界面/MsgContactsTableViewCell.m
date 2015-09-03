//
//  MsgContactsTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MsgContactsTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface MsgContactsTableViewCell ()

@property (weak , nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;

@end

@implementation MsgContactsTableViewCell

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)disPlayCellWithUser:(LightUser *)user
{
    [_avataImageView setImageWithURL:[NSURL URLWithString:[user.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _nameLabel.text = user.name;
}
@end
