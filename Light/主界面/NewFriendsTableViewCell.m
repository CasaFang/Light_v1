//
//  NewFriendsTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NewFriendsTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface NewFriendsTableViewCell ()
{
    LightUser *_user;
}
@property (weak , nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) IBOutlet UIButton    *actionBtn;

- (IBAction)onClicked:(id)sender;

@end

@implementation NewFriendsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onClicked:(id)sender{

    if ([_delegate respondsToSelector:@selector(newFriendTableCell:DidAgreedFriendWithUser:)]) {
        [_delegate  newFriendTableCell:self DidAgreedFriendWithUser:_user];
    }
}

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}


- (void)disPlayCellWithUser:(LightUser *)user
{
    _user = user;
    
    [_avataImageView setImageWithURL:[NSURL URLWithString:[user.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _nameLabel.text = user.name;
    
    if (user.status == 0) {
        
        [_actionBtn setTitle:@"同意" forState:UIControlStateNormal];
        _actionBtn.enabled = YES;
        _actionBtn.backgroundColor = LightColor(0, 157, 212);
       
    }
    else{
        
        [_actionBtn setTitle:@"已添加" forState:UIControlStateNormal];
        _actionBtn.enabled = NO;
        
         _actionBtn.backgroundColor = [UIColor lightGrayColor];
    }
}


@end
