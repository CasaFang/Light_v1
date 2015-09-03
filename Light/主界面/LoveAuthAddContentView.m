//
//  LoveAuthAddContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveAuthAddContentView.h"


@interface LoveAuthAddContentView ()

@property (weak , nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)onUploadAuth:(UITapGestureRecognizer *)sender;

@end

@implementation LoveAuthAddContentView
@synthesize delegate;

+ (instancetype)initFromNib
{
    NSArray *arr =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}

- (void)onUploadAuth:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(loveAuthUploadAuth:)]) {
        [delegate loveAuthUploadAuth:self];
    }
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
    
}
@end
