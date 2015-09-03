//
//  MsgContactsTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"
@interface MsgContactsTableViewCell : UITableViewCell

+ (instancetype)initFromNib;

- (void)disPlayCellWithUser:(LightUser *)user;

@end
