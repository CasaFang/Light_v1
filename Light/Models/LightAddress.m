//
//  KDAddress.m
//  KDStore
//
//  Created by 郑来贤 on 15/1/27.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import "LightAddress.h"
#import <JSONKit.h>


@implementation LightAddress


- (void)getAllAddressWithBlock:(getAllAddress)compeletedBlock
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LocList_cn" ofType:@"json"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSArray *countryJsonArr = [[[data objectFromJSONData] valueForKey:@"Location"] valueForKey:@"CountryRegion"];
        
        self.addressArray = [[countryJsonArr firstObject] valueForKey:@"State"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            compeletedBlock(YES,self,nil);
        });
    });

}

@end

