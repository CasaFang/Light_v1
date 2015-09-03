//
//  AccompanyAddContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightAccompany.h"
@protocol AccompanyAddContentViewDelegate;
@interface AccompanyAddContentView : UIView

@property (weak , nonatomic) id<AccompanyAddContentViewDelegate> delegate;

+ (instancetype)initFromNib;

- (void)displayWithAccompany:(LightAccompany *)accompany;


@end


@protocol AccompanyAddContentViewDelegate <NSObject>

- (void)accompantAddcontentView:(AccompanyAddContentView *)v didSelectedIndex:(int )index;

@end
