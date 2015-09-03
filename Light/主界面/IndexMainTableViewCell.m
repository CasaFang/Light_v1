//
//  IndexMainTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexMainTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface IndexMainTableViewCell ()

@property (weak , nonatomic) IBOutlet UILabel *titleLabel;
@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation IndexMainTableViewCell

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

+ (float)heightForCellWithArticle:(LightArticle *)acticle
{
    return 170;
}

- (void)displayCellWithArticle:(LightArticle *)article{

    [_avatarImageView setImageWithURL:[NSURL URLWithString:[article.picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _titleLabel.text = article.title;

}
@end
