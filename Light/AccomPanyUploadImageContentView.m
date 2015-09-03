//
//  AccomPanyUploadImageContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccomPanyUploadImageContentView.h"

@interface AccomPanyUploadImageContentView ()



- (IBAction)tagImage:(UITapGestureRecognizer *)ges;

@end


@implementation AccomPanyUploadImageContentView

+ (instancetype)initFromNib{

    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:@"AccomPanyUploadImageContentView" owner:self options:nil];
    return [arr firstObject];
}

- (void)awakeFromNib{

    _imageView.layer.borderColor = [UIColor grayColor].CGColor;
    _imageView.layer.borderWidth =1.0f;
}

- (void)tagImage:(UITapGestureRecognizer *)ges{

    if ([_delegate respondsToSelector:@selector(accomPanyUploadImageContentViewdidSelectedDoneWithImage:)]) {
        [_delegate accomPanyUploadImageContentViewdidSelectedDoneWithImage:_imageView.image];
    }
    
}

@end
