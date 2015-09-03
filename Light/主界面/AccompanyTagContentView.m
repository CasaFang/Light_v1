//
//  AccompanyTagContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccompanyTagContentView.h"

@implementation AccompanyTagContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"AccompanyTagContentView" owner:self options:nil];
    return arr[0];
}

@end
