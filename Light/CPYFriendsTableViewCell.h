//
//  CPYFriendsTableViewCell.h
//  Light
//
//  Created by ming on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightRelativeExperts.h"

@interface CPYFriendsTableViewCell : UITableViewCell
@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) IBOutlet UILabel     *contentLabel;

+ (instancetype)initFromNib;

- (void)displayCellWithRelativeExperts:(LightRelativeExperts *)expert;
@end
