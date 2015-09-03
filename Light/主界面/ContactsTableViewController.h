//
//  ContactsTableViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LightUser;
@protocol ContactsTableViewControllerDelegate ;
@interface ContactsTableViewController : UITableViewController

@property (weak , nonatomic) id<ContactsTableViewControllerDelegate> delegate;

- (void)hideLeftCancleBtn:(BOOL)isHidden;

@end

@protocol ContactsTableViewControllerDelegate <NSObject>

- (void)contacts:(ContactsTableViewController *)contact didSelectedUser:(LightUser *)user;

@end
