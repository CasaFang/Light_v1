//
//  CPYMingLiTaLuoTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightExperts.h"

@interface CPYMingLiTaLuoTableViewCell : UITableViewCell

@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) IBOutlet UILabel     *contentLabel;
@property (weak , nonatomic) IBOutlet UILabel     *tagLabel;

+ (instancetype)initFromNib;

- (void)displayCellWithExperts:(LightExperts *)expert;

@end
