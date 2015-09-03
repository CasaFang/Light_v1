//
//  AvatarEditContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AvatarEditContentViewDelegate;
@interface AvatarEditContentView : UIView

@property (weak , nonatomic) id<AvatarEditContentViewDelegate > delegate;

@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;

+ (instancetype)initFromNib;

@end

@protocol AvatarEditContentViewDelegate <NSObject>

- (void)avatarEditContentViewDidClickedEditAvatar:(AvatarEditContentView *)v;

@end
