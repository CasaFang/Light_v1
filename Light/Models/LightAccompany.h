//
//  Accompany.h
//  Light
//
//  Created by 郑来贤 on 15/8/17.
//  Copyright (c) 2015年 Light. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark -- noti

extern NSString *const  LightAccompanyAddSuccessNoti;




#pragma mark -- blocks
typedef void(^getAccompanyPeoplesBlock)(BOOL isSuccess, NSArray *peoples , NSError *error);

typedef void(^uploadImageBlock)(BOOL isSuccess, NSError *error);
typedef void(^saveAccompanyBlock)(BOOL isSuccess, NSError *error);
typedef void(^uploadImageProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface LightAccompany : NSObject

@property (nonatomic , assign) NSInteger Id;
@property (nonatomic , assign) NSInteger user_id;
@property (nonatomic , assign) long long create_time;
@property (nonatomic , assign) long long update_time;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *avatar;
@property (nonatomic , strong) NSString *brief;
@property (nonatomic , strong) NSString *self_tag;
@property (nonatomic , strong) NSString *target_tag;
@property (nonatomic , strong) NSString *picture;// 可能没有



// add accompany 时的选择的图片
@property (nonatomic , strong) UIImage  *selectedImage;
// 上传图片后获取
@property (nonatomic , assign) NSInteger picId;


- (void)getAccompanyPeoplesWithPageSize:(NSInteger )pageSize
                              andPageNo:(NSInteger )pageNo
                             andVersion:(long )version
                     andCompeletedBlock:(getAccompanyPeoplesBlock)compeltedBlock;

- (void)upLoadImageWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock;

- (void)saveWithBlock:(saveAccompanyBlock)compeletedBlock;

@end
