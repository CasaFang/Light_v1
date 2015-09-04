//
//  MarryCertificationContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryCertificationContentView.h"

@implementation MarryCertificationContentView

+ (instancetype)initFromNib{

    return [[[NSBundle mainBundle] loadNibNamed:@"MarryCertificationContentView" owner:self options:nil] firstObject];
}

- (void)onBack:(id)sender{

    if ([_delegate respondsToSelector:@selector(marryCertificationContentViewDidBack:)]) {
        [_delegate marryCertificationContentViewDidBack:self];
    }

}

@end
