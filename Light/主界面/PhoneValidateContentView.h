//
//  PhoneValidateContentView.h
//  Light
//
//  Created by FLYing on 15/9/9.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMyShareManager.h"
#import "LightUser+Change.h"

@protocol PhoneValidateContentViewDelegate;
@interface PhoneValidateContentView : UIView

@property (weak , nonatomic) id<PhoneValidateContentViewDelegate > delegate;

@property (weak , nonatomic) IBOutlet UITextField *codeTextField;

+ (instancetype)initFromNib;

@end

@protocol PhoneValidateContentViewDelegate <NSObject>

- (void)phoneValidateContentViewDidBinding:(PhoneValidateContentView *)view;


@end
