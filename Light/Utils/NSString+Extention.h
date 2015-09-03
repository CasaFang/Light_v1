//
//  NSString+Extention.h
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extention)

- (NSString *)trimWhiteSpace;
- (BOOL )isEmailFormat;
- (BOOL )isPhoneFormat;
@end
