//
//  IndexAboutContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexAboutContentView.h"

@implementation IndexAboutContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexAboutContentView" owner:self options:nil];
    return arr[0];
}

-(void)awakeFromNib{

    _versionLabel.text = [NSString stringWithFormat:@"Light %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}

- (void)onClicked:(UIControl *)sender{
    if ([_delegate respondsToSelector:@selector(aboutContentView:didSelectedSection:)]) {
        [_delegate aboutContentView:self didSelectedSection:sender.tag];
    }
}

@end
