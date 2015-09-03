//
//  LightIntroManager.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightIntroManager.h"

@implementation LightIntroManager


+ (BOOL)isShowIntro
{
    BOOL rtn = NO;
    
    NSString *currVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"app.version"];
    [[NSUserDefaults standardUserDefaults] setValue:currVersion forKey:@"app.version"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (lastVersion) {
        
        if (![lastVersion isEqualToString:currVersion]) {
            
            return YES;
        }
        
    }
    else
    {
        return YES;
    }
    return rtn;
}


@end
