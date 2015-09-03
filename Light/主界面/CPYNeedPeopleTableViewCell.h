//
//  CPYNeedPeopleTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightAccompany.h"

@interface CPYNeedPeopleTableViewCell : UITableViewCell

@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) IBOutlet UILabel     *myTargetLabel;
@property (weak , nonatomic) IBOutlet UILabel     *needTargetLabel;
@property (weak , nonatomic) IBOutlet UILabel     *contentLabel;
@property (weak , nonatomic) IBOutlet UILabel     *timetLabel;

+ (instancetype)initFromNib;

- (void)displayCellWithAccompany:(LightAccompany *)expert;

@end
