//
//  AccompanyTagContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccompanyTagContentView : UIView

@property (weak , nonatomic) IBOutlet UITextField *tagTextField;

+ (instancetype)initFromNib;

@end
