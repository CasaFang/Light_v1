//
//  UIButton+Util.h
//  
//
//  Created by FLY on 15/6/14.
//
//

#import <UIKit/UIKit.h>
@class UIButton_Util;

@protocol UIButtonDelegate <NSObject>

@required
- (void)onClick:(UIButton_Util *)button;
@optional

@end

@interface UIButton_Util : UIButton

#pragma mark - 属性
#pragma mark 代理属性，同时约定作为代理的对象必须实现<UIButtonDelegate>协议
@property (nonatomic,retain) id<UIButtonDelegate> delegate;

#pragma mark - 公共方法
#pragma mark 点击方法
-(void) click;

@end
