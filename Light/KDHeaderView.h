//
//  KDShopListTableHeaderView.h
//  KDStore
//
//  Created by 郑来贤 on 15/1/15.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDHeaderViewDelegate;
@interface KDHeaderView : UIView

- (void)setText:(NSString *)text;

@property (weak , nonatomic) id<KDHeaderViewDelegate> delegate;



@end

@protocol KDHeaderViewDelegate <NSObject>

@optional
- (void)head:(KDHeaderView *)view didSelectedWithSection:(NSInteger )section;
- (void)head:(KDHeaderView *)view didSelectedAllWithSection:(NSInteger )section;

@end
