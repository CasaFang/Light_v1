//
//  EmailValidateContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/8.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMyShareManager.h"
#import "LightUser+Change.h"

@protocol EmailValidateContentViewDelegate;
@interface EmailValidateContentView : UIView


@property (weak , nonatomic) id<EmailValidateContentViewDelegate > delegate;

@property (weak , nonatomic) IBOutlet UITextField *codeTextField;

+ (instancetype)initFromNib;

@end

@protocol EmailValidateContentViewDelegate <NSObject>

- (void)emailValidateContentViewDidBinding:(EmailValidateContentView *)view;

@end
