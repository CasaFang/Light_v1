//
//  MarryInvitationContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightNoti.h"

@protocol MarryInvitationContentViewDelegate ;
@interface MarryInvitationContentView : UIView


@property (weak , nonatomic) id<MarryInvitationContentViewDelegate >delegate;
+ (instancetype)initFromNib;

- (void)displayWithNoti:(LightNoti *)noti;



@end


@protocol MarryInvitationContentViewDelegate <NSObject>

- (void)marryInvitationContentViewDidAgreed:(MarryInvitationContentView *)v;
- (void)marryInvitationContentViewDidRefused:(MarryInvitationContentView *)v;

@end
