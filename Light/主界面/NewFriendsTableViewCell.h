//
//  NewFriendsTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"
@protocol NewFriendsTableViewCellDelegate;

@interface NewFriendsTableViewCell : UITableViewCell


@property (weak , nonatomic) id<NewFriendsTableViewCellDelegate> delegate;

+ (instancetype)initFromNib;

- (void)disPlayCellWithUser:(LightUser *)user;

@end

@protocol NewFriendsTableViewCellDelegate <NSObject>

- (void)newFriendTableCell:(NewFriendsTableViewCell *)cell DidAgreedFriendWithUser:(LightUser *)user;

@end
