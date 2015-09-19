//
//  CPYFriendTableViewCell.h
//  Light
//
//  Created by ming on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightExperts.h"
@interface CPYFriendTableViewCell : UITableViewCell
@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) IBOutlet UILabel     *contentLabel;

+ (instancetype)initFromNib;

- (void)displayCellWithExperts:(LightExperts *)expert;
@end
