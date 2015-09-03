//
//  NSString+Date.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSDate *)stringToDateWithFormat:(NSString *)format{

    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    dformat.dateFormat = format;
    return [dformat dateFromString:self];
}

@end
