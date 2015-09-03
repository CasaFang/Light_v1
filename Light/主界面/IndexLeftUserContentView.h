//
//  IndexLeftUserContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"
#import "LightUser+Change.h"
@protocol IndexLeftUserContentViewDelegate;


@interface IndexLeftUserContentView : UIView

@property (weak , nonatomic) id<IndexLeftUserContentViewDelegate> delegate;

+ (instancetype)initFromNib;

- (void)displayWithUser:(LightUser *)user;

@end

@protocol IndexLeftUserContentViewDelegate <NSObject>

- (void)userContentView:(IndexLeftUserContentView *)v didSelectedSection:(NSInteger )section;

@end
