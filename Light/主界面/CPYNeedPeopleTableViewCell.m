//
//  CPYNeedPeopleTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "CPYNeedPeopleTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation CPYNeedPeopleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}
+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"CPYNeedPeopleTableViewCell" owner:self options:nil];
    return arr[0];
}

- (void)displayCellWithAccompany:(LightAccompany *)accompany{
    
    [_avatarImageView setImageWithURL:[NSURL URLWithString:[accompany.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _nameLabel.text = accompany.name;
    _contentLabel.text = accompany.brief;
    _needTargetLabel.text = accompany.target_tag;
    _myTargetLabel.text = accompany.self_tag;
    
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:accompany.update_time/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    
    
    _timetLabel.text = [formatter stringFromDate:date];
}



@end
