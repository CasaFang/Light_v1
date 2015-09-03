//
//  NSString+Extention.m
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (NSString *)trimWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
- (BOOL)isEmailFormat
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
}
- (BOOL)isPhoneFormat
{
    NSString * mobileRegex = @"^^1[3|4|5|8][0-9]\\d{4,8}$$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    
    return [phoneTest evaluateWithObject:self];
}

@end
