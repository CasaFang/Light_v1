//
//  LightAuth.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getAuthsBlock)(BOOL isSuccess ,NSArray *auths, NSError *error);

@interface LightAuth : NSObject

@property (assign , nonatomic) NSInteger Id;
@property (strong , nonatomic) NSString  *title;
@property (strong , nonatomic) NSString  *pic;
@property (strong , nonatomic) NSString  *content;
@property (strong , nonatomic) NSString  *brief;
@property (assign , nonatomic) long       create_time;
@property (assign , nonatomic) long       update_time;

- (instancetype)initFromDic:(NSDictionary *)dic;


- (void)getAuthsWithPageSize:(NSInteger )pageSize
                    andPageNo:(NSInteger )pageNo
                   andVersion:(long )version
           andCompeletedBlock:(getAuthsBlock)compeltedBlock;



@end
