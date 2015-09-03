//
//  LightArticle.m
//  
//
//  Created by FLY on 15/6/14.
//
//

#import "LightArticle.h"
#import "HtttpReques.h"
#import "ModelConfig.h"

@implementation LightArticle

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        [self parseData:dic];
    }
    return self;
}
- (void)parseData:(NSDictionary *)d
{
    self.Id = [d[@"id"] integerValue];
    self.title = d[@"title"];
    self.content = d[@"content"];
    self.picUrl = d[@"pic"];
    self.create_time = [d[@"create_time"] longValue];
    self.update_time = [d[@"update_time"] longValue];
    
}

- (void)getArticlesWithPageSize:(NSInteger)pageSize andPageNo:(NSInteger)pageNo andVersion:(long)version andCompeletedBlock:(getArticlesBlock)compeltedBlock
{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:pageSize] forKey:@"page_size"];
    [parameters setValue:[NSNumber numberWithInteger:pageNo] forKey:@"page_no"];
    [parameters setValue:[NSNumber numberWithLong:version] forKey:@"version"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/article/list.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
             NSMutableArray *arr = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
               
                NSArray *articles = resturnDic[@"articles"];
                
                if (articles && ![articles isKindOfClass:[NSNull class]]) {
                    
                    for (NSDictionary *d in articles) {
                        
                        LightArticle *instance = [[LightArticle alloc]initWithDic:d];
                        
                        [arr addObject:instance];
                    }
                }

                compeltedBlock(YES,arr,nil);
            }
            else if (validate.result_code == 1)
            {
                compeltedBlock(YES,arr,nil);
            }
            else
            {
                compeltedBlock(NO,arr,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeltedBlock(NO,nil,error);
        }
        
    }];


}


@end
