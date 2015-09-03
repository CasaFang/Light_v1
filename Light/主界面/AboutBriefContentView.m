//
//  AboutBriefContentView.m
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AboutBriefContentView.h"

@implementation AboutBriefContentView

+ (instancetype)initFromNib{

    return [[[NSBundle mainBundle]loadNibNamed:@"AboutBriefContentView" owner:self options:nil] firstObject];
}

-(void)awakeFromNib{
    
    _versionLabel.text = [NSString stringWithFormat:@"Light %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}

@end
