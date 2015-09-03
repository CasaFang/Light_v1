//
//  AccompanyUploadImageViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightAccompany.h"

@protocol AccompanyUploadImageViewControllerDelegate ;
@interface AccompanyUploadImageViewController : UIViewController

@property (weak , nonatomic) id<AccompanyUploadImageViewControllerDelegate > delegate;

@property (strong , nonatomic) LightAccompany *accompany;

@end

@protocol AccompanyUploadImageViewControllerDelegate  <NSObject>

- (void)accompanyUploadImageViewController:(AccompanyUploadImageViewController *)c didSelectedImage:(UIImage *)image;

@end
