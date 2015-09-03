//
//  IndexMainTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/7/31.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightArticle.h"

@interface IndexMainTableViewCell : UITableViewCell

+ (instancetype)initFromNib;

+(float)heightForCellWithArticle:(LightArticle *)acticle;

- (void)displayCellWithArticle:(LightArticle *)article;

@end
