//
//  ContactsDetailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"
@protocol ContactsDetailContentViewDelegate;
@interface ContactsDetailContentView : UIView

@property (weak  , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak , nonatomic) id<ContactsDetailContentViewDelegate >delegate;
+ (instancetype)initFromNib;

- (void)displayWithUser:(LightUser *)user;


@end

@protocol ContactsDetailContentViewDelegate <NSObject>

- (void)ContactsDetailContentViewDidClickedAddFriend;

@end
