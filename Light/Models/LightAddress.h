//
//  KDAddress.h
//  KDStore
//
//  Created by 郑来贤 on 15/1/27.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LightAddress;

typedef void(^getAllAddress)(BOOL isSuccess ,LightAddress *address, NSError *error);

@interface LightAddress : NSObject

@property (strong , nonatomic) NSArray *addressArray;

- (void)getAllAddressWithBlock:(getAllAddress)compeletedBlock;


@end


