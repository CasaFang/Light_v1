//
//  ContactsDetailContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "ContactsDetailContentView.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation ContactsDetailContentView

+ (instancetype)initFromNib{
    
    return  [[[NSBundle mainBundle]loadNibNamed:@"ContactsDetailContentView" owner:self options:nil] firstObject];
}


- (IBAction)onCliced:(id)sender
{

    if ([_delegate respondsToSelector:@selector(ContactsDetailContentViewDidClickedAddFriend)]) {
        [_delegate ContactsDetailContentViewDidClickedAddFriend];
    }
}

- (void)displayWithUser:(LightUser *)user{

    [_avatarImageView setImageWithURL:[NSURL URLWithString:user.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _nameLabel.text = user.name;
}

@end
