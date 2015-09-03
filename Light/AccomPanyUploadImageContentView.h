//
//  AccomPanyUploadImageContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccomPanyUploadImageContentViewDelegate ;
@interface AccomPanyUploadImageContentView : UIView

@property (weak , nonatomic) id<AccomPanyUploadImageContentViewDelegate> delegate;

@property (weak , nonatomic) IBOutlet UIImageView *imageView;

+ (instancetype)initFromNib;

@end

@protocol AccomPanyUploadImageContentViewDelegate <NSObject>

- (void)accomPanyUploadImageContentViewdidSelectedDoneWithImage:(UIImage *)image;

@end
