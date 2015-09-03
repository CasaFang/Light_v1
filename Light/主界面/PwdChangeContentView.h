//
//  PwdChangeContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdChangeContentView : UIView

@property (weak , nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak , nonatomic) IBOutlet UITextField *nPwdTextField;
@property (weak , nonatomic) IBOutlet UITextField *confirmPwdTextField;

+ (instancetype)initFromNib;

@end

