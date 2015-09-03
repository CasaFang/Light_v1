//
//  AccompanyTagViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccompanyTagViewControllerDelegate;
@interface AccompanyTagViewController : UIViewController

@property (strong , nonatomic) NSString *tagStr;

@property (weak , nonatomic) id<AccompanyTagViewControllerDelegate > delegate;
@property (assign , nonatomic) BOOL isSelfTag;
@end


@protocol AccompanyTagViewControllerDelegate <NSObject>

- (void)accompanyTagViewController:(AccompanyTagViewController *)c didSeletedTag:(NSString *)tag;

@end