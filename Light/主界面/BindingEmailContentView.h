//
//  BindingEmailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BindingEmailContentViewDelegate;
@interface BindingEmailContentView : UIView

@property (weak , nonatomic) id<BindingEmailContentViewDelegate >delegate;

+ (instancetype)initFromNib;

@end

@protocol BindingEmailContentViewDelegate <NSObject>

- (void)bindingEmailContentViewDidBindingEmail:(BindingEmailContentView *)v;

@end