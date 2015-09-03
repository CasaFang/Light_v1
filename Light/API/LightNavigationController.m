//
//  LightNavigationController.m
//  
//
//  Created by FLY on 15/6/15.
//
//

#import "LightNavigationController.h"


@implementation LightNavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavTheme];
}

/** 设置导航栏主题 */
- (void)setupNavTheme {
    
    // 导航栏背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7.jpg"]
                 forBarMetrics:UIBarMetricsDefault];

    navBar.translucent = NO;
//    navBar.tintColor = LightColor(0, 157, 212);
    
    // 导航栏标题
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0f];
    [navBar setTitleTextAttributes:dict];
    // 导航栏按钮
    navBar.tintColor = [UIColor whiteColor];
    
    // 标签栏颜色
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.tintColor = LightBlue;
    tabBar.barTintColor = LightColor(248, 248, 248);
    if (IOS8) {
        tabBar.translucent = NO;
    }
}


@end
