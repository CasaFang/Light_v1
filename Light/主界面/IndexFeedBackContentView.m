//
//  IndexFeedBackContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexFeedBackContentView.h"

@implementation IndexFeedBackContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexFeedBackContentView" owner:self options:nil];
    return arr[0];
}
- (void)awakeFromNib{
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imageView.layer.borderWidth = 1.0;
}

- (void)onUploadPic:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(feedBackContentViewDidClickedUploadPic:)]) {
        [_delegate feedBackContentViewDidClickedUploadPic:self];
    }
}

- (void)setImage:(UIImage *)image
{
    _image =  image;
    _imageView.image = image;
}
@end
