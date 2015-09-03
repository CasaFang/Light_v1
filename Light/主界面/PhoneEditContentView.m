//
//  PhoneEditContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PhoneEditContentView.h"

@implementation PhoneEditContentView

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"PhoneEditContentView" owner:self options:nil];
    return arr[0];
}

@end
