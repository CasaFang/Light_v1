//
//  IndexLeftUserContentView.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftUserContentView.h"

@interface IndexLeftUserContentView ()

- (IBAction)onClicked:(UIControl *)sender;

@property (weak , nonatomic) IBOutlet UILabel  *areaLabel;
@property (weak , nonatomic) IBOutlet UILabel  *nickLabel;
@property (weak , nonatomic) IBOutlet UILabel  *birthdayLabel;
@property (weak , nonatomic) IBOutlet UILabel  *signLabel;
@property (weak , nonatomic) IBOutlet UILabel  *physiology_genderLabel;
@property (weak , nonatomic) IBOutlet UILabel  *society_genderLabel;

@end

@implementation IndexLeftUserContentView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"IndexLeftUserContentView" owner:self options:nil];
    return arr[0];
}

- (void)onClicked:(UIControl *)sender
{
    if ([_delegate respondsToSelector:@selector(userContentView:didSelectedSection:)]) {
        [_delegate userContentView:self didSelectedSection:sender.tag];
    }
}

- (void)displayWithUser:(LightUser *)user{
    
    _areaLabel.text = user.area;
    _birthdayLabel.text = [NSString stringWithFormat:@"%ld",(long)user.birthday];
    _signLabel.text = user.sigNature;
    _physiology_genderLabel.text = [user getSexWithSexType:user.physiology_gender];
    _society_genderLabel.text = [user getSexWithSexType:user.society_gender];
    _nickLabel.text = user.name;

}


@end
