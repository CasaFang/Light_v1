//
//  LightRelativeExperts.h
//  Light
//
//  Created by ming on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^getRelativeExpertsBlock)(BOOL isSuccess, NSArray *experts ,NSError *error);

@interface LightRelativeExperts : NSObject

@property (strong , nonatomic) NSString   *name;
@property (strong , nonatomic) NSString   *avatar;
// 专家id
@property (assign , nonatomic) NSInteger  Id;
// 专家对应的id
@property (assign , nonatomic) NSInteger  user_id;
@property (strong , nonatomic) NSString   *good_at;
//个人简介
@property  (strong, nonatomic) NSString   *pDescription;
@property  (strong, nonatomic) NSString   *lgbt;
@property  (strong, nonatomic) NSString   *cases;

- (instancetype)initFromDic:(NSDictionary *)d;

- (void)getExpertsWithBlock:(getRelativeExpertsBlock)compeletedBlock;

@end
