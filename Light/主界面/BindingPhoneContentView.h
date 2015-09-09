//
//  BindingPhoneContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BindingPhoneContentViewDelegate;
@interface BindingPhoneContentView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak , nonatomic ) id<BindingPhoneContentViewDelegate > delegate;

+ (instancetype)initFromNib;

@end

@protocol BindingPhoneContentViewDelegate <NSObject>

- (void)bindingPhoneContentViewDidBinding:(BindingPhoneContentView *)v;

@end
