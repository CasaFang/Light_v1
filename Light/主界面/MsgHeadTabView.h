//
//  MsgContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgHeadTabViewDelegate;
@interface MsgHeadTabView : UIView

@property (weak , nonatomic) id<MsgHeadTabViewDelegate> delegate;

@property (assign ,readonly, nonatomic) int currentSelectedIndex;

+ (instancetype)initFromNib;
// 0 --1
- (void)setSelectedIndex:(int)index;

@end

@protocol MsgHeadTabViewDelegate <NSObject>

- (void)didSelectedMsgTab:(MsgHeadTabView *)view;
- (void)didSelectedContactsTab:(MsgHeadTabView *)view;

@end
