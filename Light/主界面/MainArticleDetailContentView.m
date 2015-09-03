//
//  MainArticleDetailContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MainArticleDetailContentView.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface MainArticleDetailContentView ()

@property (weak , nonatomic) IBOutlet UILabel *contentLabel;
@property (weak , nonatomic) IBOutlet UIImageView *imageView;
@property (weak , nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak , nonatomic) IBOutlet UILabel *authorTitleLabel;
@property (weak , nonatomic) IBOutlet UILabel *authorBriefLabel;
@property (weak , nonatomic) IBOutlet UILabel *articleTitileLable;

-(IBAction)onBack:(id)sender;
-(IBAction)onGeiMoney:(id)sender;


@end

@implementation MainArticleDetailContentView

+ (CGFloat)heightForContentViewWithArticle:(LightArticle *)article{

    CGFloat otherHeight = 210;
    
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

    
    CGSize sizeToFit = [article.content  sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0] constrainedToSize:CGSizeMake(296.0/320.0*WINSIZE.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (sizeToFit.width == 0)
    {
        sizeToFit = CGSizeZero;
    }
#pragma clang diagnostic pop
    return sizeToFit.height+otherHeight;

}

+ (instancetype)initFromNib{

    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MainArticleDetailContentView" owner:self options:nil];
    return arr[0];
}

- (void)displayContentView:(LightArticle *)article{
    [_imageView setImageWithURL:[NSURL URLWithString:[article.picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _avatarImageView setImageWithURL:[NSURL URLWithString:<#(NSString *)#>] completed:<#^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)completedBlock#> usingActivityIndicatorStyle:<#(UIActivityIndicatorViewStyle)#>
    _contentLabel.text = article.content;
    _articleTitileLable.text = article.title;
    
}

- (void)onBack:(id)sender{

    if ([_delegate respondsToSelector:@selector(articleDetailContentViewDidBack:)]) {
        [_delegate articleDetailContentViewDidBack:self];
    }
}
- (void)onGeiMoney:(id)sender{

    if ([_delegate respondsToSelector:@selector(articleDetailContentViewDidGeiMoney:)]) {
        [_delegate articleDetailContentViewDidGeiMoney:self];
    }
}
@end
