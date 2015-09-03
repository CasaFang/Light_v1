//
//  LightIntroPage.m
//  
//
//  CrLightted by FLY on 15/6/10.
//
//

#import "LightIntroPage.h"

@implementation LightIntroPage

+ (LightIntroPage *)page {
    LightIntroPage *newPage = [[LightIntroPage alloc] init];
    newPage.imgPositionY    = 50.0f;
    newPage.titlePositionY  = 160.0f;
    newPage.descPositionY   = 140.0f;
    newPage.title = @"";
    newPage.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    newPage.titleColor = [UIColor whiteColor];
    newPage.desc = @"";
    newPage.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
    newPage.descColor = [UIColor whiteColor];
    
    return newPage;
}

+ (LightIntroPage *)pageWithCustomView:(UIView *)customV {
    LightIntroPage *newPage = [[LightIntroPage alloc] init];
    newPage.customView = customV;
    
    return newPage;
}
@end
