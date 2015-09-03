//
//  BindingEmailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindingEmailContentView : UIView

@property (weak , nonatomic) IBOutlet UIButton *btn;
@property (weak , nonatomic) IBOutlet UITextField *phoneTextField;

+ (instancetype)initFromNib;

@end
