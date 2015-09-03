//
//  NSDate+NSString.m
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)

- (NSString *)dateToStringWithFormat:(NSString *)format{
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    dformat.dateFormat = format;
    return [dformat stringFromDate:self];
    
}

@end
