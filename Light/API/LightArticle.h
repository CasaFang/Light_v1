//
//  LightArticle.h
//  
//
//  Created by FLY on 15/6/14.
//
//

#import <Foundation/Foundation.h>

#pragma mark  -- blocks
typedef void(^getArticlesBlock)(BOOL isSuccess,NSArray *articles, NSError *error);

@interface LightArticle : NSObject

#pragma mark - 文章id
@property (nonatomic,assign) NSInteger Id;
#pragma mark － 文章标题
@property (nonatomic,readwrite,copy) NSString *title;
#pragma mark -  文章内容
@property (nonatomic,readwrite,copy) NSString *content;
#pragma mark -  文章图片url
@property (nonatomic,readwrite,copy) NSString *picUrl;

@property (nonatomic ,assign) long   create_time;

@property (nonatomic ,assign) long   update_time;



- (instancetype)initWithDic:(NSDictionary *)dic;

- (void)getArticlesWithPageSize:(NSInteger )pageSize
                      andPageNo:(NSInteger )pageNo
                    andVersion:(long )version
             andCompeletedBlock:(getArticlesBlock)compeltedBlock;

@end
