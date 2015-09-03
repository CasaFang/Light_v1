//
//  ModelConfig.h
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#ifndef Light_ModelConfig_h
#define Light_ModelConfig_h

#define Light_GetStringValueFromDicWithKey(dic,key) (![dic objectForKey:key])||([[dic objectForKey:key] isKindOfClass:[NSNull class]])?nil:[NSString stringWithFormat:@"%@",[dic objectForKey:key]]



#import "NSString+Extention.h"
#import "HtttpReques.h"
#import "LightValidateCode.h"
#import "LightMyShareManager.h"
#import "LightUser+Friend.h"
#import "LightUser+Login.h"
#import "LightUser+Register.h"

#endif
