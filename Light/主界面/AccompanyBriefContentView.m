//
//  AccompanyBriefContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccompanyBriefContentView.h"

@implementation AccompanyBriefContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"AccompanyBriefContentView" owner:self options:nil];
    return [arr firstObject];
}

@end
