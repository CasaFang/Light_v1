//
//  ContactsSearchViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LightUser;
@protocol ContactsSearchViewControllerDelegate;

@interface ContactsSearchViewController : UIViewController

@property (weak , nonatomic) id<ContactsSearchViewControllerDelegate> delegate;

@end

@protocol ContactsSearchViewControllerDelegate <NSObject>

- (void)contactsSearch:(ContactsSearchViewController *)contact didSelectedUser:(LightUser *)user;

@end
