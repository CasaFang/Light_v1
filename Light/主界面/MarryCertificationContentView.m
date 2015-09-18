//
//  MarryCertificationContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MarryCertificationContentView.h"
#import <HPGrowingTextView.h>
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "MarryPagePicAddCollectionViewCell.h"
#import "MarryPagePicCollectionViewCell.h"

@interface MarryCertificationContentView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{

    NSArray *picArray;
}

@property (weak, nonatomic) IBOutlet UIImageView *marryerAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *marryedAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *marryerName;
@property (weak, nonatomic) IBOutlet UILabel *marryedName;
@property (weak, nonatomic) IBOutlet UILabel *marryTime;
@property (weak, nonatomic) IBOutlet UITextField *marryTitle;
@property (weak, nonatomic) IBOutlet HPGrowingTextView *marryStory;
@property (weak, nonatomic) IBOutlet UICollectionView *picCollection;

@end

@implementation MarryCertificationContentView

+ (instancetype)initFromNib{

    return [[[NSBundle mainBundle] loadNibNamed:@"MarryCertificationContentView" owner:self options:nil] firstObject];
}

- (void)displayWithMarryPage:(LightMarryPage *)marryPage{

    [_marryedAvatar setImageWithURL:[NSURL URLWithString:marryPage.fromAvatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [_marryerAvatar setImageWithURL:[NSURL URLWithString:marryPage.toAvatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [_coverImageView setImageWithURL:[NSURL URLWithString:marryPage.cover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    _marryerName.text = marryPage.fromUserName;
    _marryedName.text = marryPage.toUserName;
    _marryTitle.text  = marryPage.title;
    _marryStory.text  = marryPage.content;
    _marryTime.text   = marryPage.createTime;
    
}

- (void)disMarryPagePicsWithPics:(NSArray *)pics{

    picArray = pics;
    
    [_picCollection reloadData];
}


- (void)awakeFromNib{

    _marryStory.placeholder = @"说说我们的爱情吧";
    _marryStory.maxHeight = 135;
    _marryStory.minHeight = 135;
    _marryStory.editable = NO;
    
    picArray = @[];
    
    [_picCollection registerClass:[MarryPagePicAddCollectionViewCell class] forCellWithReuseIdentifier:@"picAddCellIdentifier"];
    
    [_picCollection registerClass:[MarryPagePicCollectionViewCell class] forCellWithReuseIdentifier:@"picCellIdentifier"];
    _picCollection.backgroundColor = [UIColor whiteColor];

}
- (void)onBack:(id)sender{

    if ([_delegate respondsToSelector:@selector(marryCertificationContentViewDidBack:)]) {
        [_delegate marryCertificationContentViewDidBack:self];
    }

}

- (IBAction)onEditBtnClicked:(id)sender
{
    _marryStory.editable = YES;
    _marryTitle.enabled = YES;
}

#pragma mark --UICollectionViewDataSource and UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row < picArray.count) {
        
        MarryPagePicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picCellIdentifier" forIndexPath:indexPath];
        
        return cell;
    }
    else{
    
        MarryPagePicAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picAddCellIdentifier" forIndexPath:indexPath];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row <picArray.count) {
        
        if ([_delegate respondsToSelector:@selector(marryCertificationContentViewDidClickedPic:andPicArray:andCurrentIndex:)]) {
            [_delegate marryCertificationContentViewDidClickedPic:self andPicArray:picArray andCurrentIndex:indexPath];
        }
    }
    else{
    
        if ([_delegate respondsToSelector:@selector(marryCertificationContentViewDidAddPic:)]) {
            [_delegate marryCertificationContentViewDidAddPic:self];
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return picArray.count+1;
}


@end
