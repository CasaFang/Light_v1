//
//  EditNickNameContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNickNameContentView : UIView

@property (weak , nonatomic) IBOutlet UITextField *textField;

+ (instancetype)initFromNib;

@end
