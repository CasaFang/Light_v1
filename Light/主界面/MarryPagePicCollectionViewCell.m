//
//  MarryPagePicCollectionViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/9/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryPagePicCollectionViewCell.h"

@implementation MarryPagePicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MarryPagePicCollectionViewCell" owner:self options:nil] firstObject];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
