//
//  IndexMainNPCSTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexMainNPCSTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>


@interface IndexMainNPCSTableViewCell ()
{

    NSArray *lightNPCS;
}

@property (weak , nonatomic) IBOutlet UIImageView *imageV1;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel1;
@property (weak , nonatomic) IBOutlet UILabel     *fieldLabel1;

@property (weak , nonatomic) IBOutlet UIImageView *imageV2;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel2;
@property (weak , nonatomic) IBOutlet UILabel     *fieldLabel2;


@property (weak , nonatomic) IBOutlet UIImageView *imageV3;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel3;
@property (weak , nonatomic) IBOutlet UILabel     *fieldLabel3;

@property (weak , nonatomic) IBOutlet UIImageView *imageV4;
@property (weak , nonatomic) IBOutlet UILabel     *nameLabel4;
@property (weak , nonatomic) IBOutlet UILabel     *fieldLabel4;

@end

@implementation IndexMainNPCSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return arr[0];
}


- (IBAction)onClicked:(UIButton *)sender
{

    int index = (int)sender.tag;
    
    if (lightNPCS.count >= index) {
      
        if ([_delegate respondsToSelector:@selector(cell:didSelectedUser:)]) {
            
            [_delegate cell:self didSelectedUser:lightNPCS[index]];
        }
    }
    
    
    
}

- (void)disPlayWithNPCS:(NSArray *)npcs{
    
    lightNPCS = npcs;
    
    for (int i = 0; i<npcs.count; i++) {
        
        if (i==0) {
            
            LightNPC *npc0 = npcs[0];
            
            [_imageV1 setImageWithURL:[NSURL URLWithString:npc0.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _nameLabel1.text =npc0.name;
            _fieldLabel1.text = npc0.field;
        }
        
        if (i==1) {
            
            LightNPC *npc1 = npcs[1];
            
            [_imageV2 setImageWithURL:[NSURL URLWithString:npc1.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _nameLabel2.text =npc1.name;
            _fieldLabel2.text = npc1.field;
        }
        
        if (i==2) {
            
            LightNPC *npc2 = npcs[2];
            
            [_imageV3 setImageWithURL:[NSURL URLWithString:npc2.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _nameLabel3.text =npc2.name;
            _fieldLabel3.text = npc2.field;
        }
        
        if (i==3) {
            
            LightNPC *npc3 = npcs[3];
            
            [_imageV4 setImageWithURL:[NSURL URLWithString:npc3.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _nameLabel4.text =npc3.name;
            _fieldLabel4.text = npc3.field;
        }
        
    }
}

@end
