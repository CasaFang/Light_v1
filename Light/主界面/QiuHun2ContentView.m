//
//  QiuHun2ContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "QiuHun2ContentView.h"

@implementation QiuHun2ContentView

+ (instancetype)initFromNib{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"QiuHun2ContentView" owner:self options:nil];
    return arr[0];
}

- (void)awakeFromNib{

    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderColor = LightDark.CGColor;
    _bgView.layer.borderWidth= 1.0f;
}
@end
