//
//  AccompanyBriefContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccompanyBriefContentView : UIView

@property (weak , nonatomic) IBOutlet UITextView *briefTextView;

+ (instancetype)initFromNib;

@end
