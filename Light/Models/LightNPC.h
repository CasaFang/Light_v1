//
//  LightNPC.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^getNpcsBlock)(BOOL isSuccess ,NSArray *npcs, NSError *error);

@interface LightNPC : NSObject


@property (strong , nonatomic) NSString   *name;
@property (strong , nonatomic) NSString   *avatar;
@property (assign , nonatomic) NSInteger  Id;
@property (strong , nonatomic) NSString   *welcomeWord;
@property (strong , nonatomic) NSString   *field;


- (instancetype)initWithDic:(NSDictionary *)dic;

- (void)getNpcsWithBlock:(getNpcsBlock)compeletedBlock;

@end
