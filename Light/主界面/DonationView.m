//
//  DonationView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "DonationView.h"

@interface DonationView ()

@end

@implementation DonationView

+ (instancetype)initFromNib{

    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"DonationView" owner:self options:nil];
    return arr[0];
}

@end
