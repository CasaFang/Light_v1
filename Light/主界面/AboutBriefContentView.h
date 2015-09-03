//
//  AboutBriefContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutBriefContentView : UIView

@property (weak , nonatomic) IBOutlet UILabel *versionLabel;

+ (instancetype)initFromNib;

@end
