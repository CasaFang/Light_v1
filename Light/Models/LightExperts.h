//
//  LightExperts.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^getExpertsBlock)(BOOL isSuccess, NSArray *experts ,NSError *error);

typedef NS_ENUM(NSInteger, LightExpertField) {
    
    LightExpertFieldPeiBanShi     = 10,
    LightExpertFieldXinLiZiXunShi = 11,
    LightExpertFieldMingLiShi     = 20,
    LightExpertFieldLvShi         = 30,
};


@interface LightExperts : NSObject

@property (strong , nonatomic) NSString   *name;
@property (strong , nonatomic) NSString   *avatar;
// 专家id
@property (assign , nonatomic) NSInteger  Id;
// 专家对应的id
@property (assign , nonatomic) NSInteger  user_id;
@property (strong , nonatomic) NSString   *good_at;
// 认证
@property (strong , nonatomic) NSString   *auth;
@property (strong , nonatomic) NSString   *brief;
@property (strong , nonatomic) NSString   *tag;


- (instancetype)initFromDic:(NSDictionary *)d;

- (void)getExpertsWithField:(LightExpertField )field andBlock:(getExpertsBlock)compeletedBlock;


@end
