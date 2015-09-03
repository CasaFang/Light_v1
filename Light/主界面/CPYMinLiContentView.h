//
//  CPYMinLiContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPYMinLiContentViewDelegate;

@interface CPYMinLiContentView : UIView

@property (weak , nonatomic ) id<CPYMinLiContentViewDelegate> delegate;

+ (instancetype)initFromNib;

@end

@protocol CPYMinLiContentViewDelegate <NSObject>

- (void)minliContentView:(CPYMinLiContentView *)v didSelectedBtnIndex:(NSInteger )index;

@end
