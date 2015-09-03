//
//  AddrSelectTableViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddrSelectTableViewControllerDelegate;
@interface AddrSelectTableViewController : UITableViewController

@property (strong , nonatomic) NSDictionary *selectedAddressDic;

@property (weak , nonatomic) id<AddrSelectTableViewControllerDelegate >delegate;

@end

@protocol AddrSelectTableViewControllerDelegate <NSObject>

- (void)addrSelectTableViewControllerDidSelectedAddr:(NSString *)addressStrValue;

@end
