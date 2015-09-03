//
//  IndexLeftContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndexLeftContentViewDelegate;
@interface IndexLeftContentView : UIView

@property (weak , nonatomic) id<IndexLeftContentViewDelegate> delegate;

@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak , nonatomic) IBOutlet UILabel     *nameLabel;

+ (instancetype)initFromNib;

- (void)disPlayView;


@end

@protocol IndexLeftContentViewDelegate <NSObject>

- (void)contentView:(IndexLeftContentView *)v didSelectedSection:(NSInteger)section;

@end
