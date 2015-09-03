//
//  MsgMsgHeadView.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MsgMsgHeadViewDelegate;
@interface MsgMsgHeadView : UIView

@property (weak , nonatomic) id<MsgMsgHeadViewDelegate> delegate;

@property (weak , nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak , nonatomic) IBOutlet UILabel     *titleLabel;

@property (weak , nonatomic) IBOutlet UILabel     *badgeLabel;


+ (instancetype)initFromNib;

@end

@protocol MsgMsgHeadViewDelegate <NSObject>

- (void)msgMsgHeadDidClickedView:(MsgMsgHeadView *)v;

@end
