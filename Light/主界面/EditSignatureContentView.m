//
//  EditSignatureContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "EditSignatureContentView.h"

@implementation EditSignatureContentView

+ (instancetype)initFromNib{

    return  [[[NSBundle mainBundle]loadNibNamed:@"EditSignatureContentView" owner:self options:nil] firstObject];
}

@end
