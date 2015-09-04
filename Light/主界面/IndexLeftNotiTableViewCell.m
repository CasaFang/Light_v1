//
//  IndexLeftNotiTableViewCell.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftNotiTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation IndexLeftNotiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initFromNib{
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexLeftNotiTableViewCell" owner:self options:nil];
    return arr[0];
}

- (void)displayCellWithNoti:(LightNoti *)noti{
    
    NSString *contentStr = @"";
    
    if (noti.type == 3) {
        
        LightMarry *marry = noti.notiObject;
        contentStr = [NSString stringWithFormat:@"@ %@像你发出了求婚请求",marry.marryerName];
    }
    else if (noti.type == 4){
        
        LightMarry *marry = noti.notiObject;
    
        if (marry.status == -1) {
            
             contentStr = [NSString stringWithFormat:@"@ %@拒绝你的认证请求",marry.marryedName];
        }
        else if(marry.status == 1){
        
             contentStr = [NSString stringWithFormat:@"@ %@同意你的认证请求,Light为你们创建认证请求",marry.marryedName];
        }
        else if (marry.status == 0){
            
            contentStr = [NSString stringWithFormat:@"@ %@的求婚请求已发送",marry.marryedName];
        }
       
    }
    _contentLabel.text = contentStr;
   
    
}


@end
