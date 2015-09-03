//
//  EditNickNameContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EditNickNameContentView.h"

@implementation EditNickNameContentView

+ (instancetype)initFromNib{
    
    return  [[[NSBundle mainBundle]loadNibNamed:@"EditNickNameContentView" owner:self options:nil] firstObject];
}

@end
