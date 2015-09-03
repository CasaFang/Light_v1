//
//  KDShopListTableHeaderView.m
//  KDStore
//
//  Created by 郑来贤 on 15/1/15.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import "KDHeaderView.h"

@interface KDHeaderView ()

@property (strong , nonatomic) UILabel *titleLabel;


@end

@implementation KDHeaderView
@synthesize titleLabel,delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = LightColorRGBA(242, 242, 242, .5);
        
        UIImageView *inputLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, .5)];
        inputLine.backgroundColor = LightColorRGBA(235, 235, 235, 1.0);
//        inputLine.backgroundColor = [UIColor redColor];
        [self addSubview:inputLine];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, .5, frame.size.width-40, frame.size.height-1)];
        titleLabel.textColor = LightColorRGBA(51, 51, 51, 1);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0F];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
        
        inputLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-.5, frame.size.width, .5)];
        inputLine.backgroundColor = LightColorRGBA(235, 235, 235, 1.0);
        [self addSubview:inputLine];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelected:)];
        ges.numberOfTapsRequired = 1;
        ges.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:ges];
    
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    titleLabel.text = text;
}

- (void)didSelected:(UITapGestureRecognizer *)ges
{
    if ([delegate respondsToSelector:@selector(head:didSelectedWithSection:)]) {
        [delegate head:self didSelectedWithSection:self.tag];
    }
}



@end
