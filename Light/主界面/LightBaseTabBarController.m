//
//  LightBaseTabBarController.m
//  
//
//  Created by FLY on 15/6/17.
//
//

#import "LightBaseTabBarController.h"
#import "MsgViewController.h"
#import "CPYViewController.h"
#import "LoveViewController.h"
#import "KDGViewController.h"
#import "IndexMainViewController.h"
#import "LightNavigationController.h"


@interface LightBaseTabBarController ()<UITabBarControllerDelegate>


@end

@implementation LightBaseTabBarController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    // Step 1: Create your controllers.
    IndexMainViewController *index = [[IndexMainViewController alloc] init];
    
    LightNavigationController *indexNavi = [[LightNavigationController alloc] initWithRootViewController:index];
    
    MsgViewController *msg = [[MsgViewController alloc]init];
    
    LightNavigationController *msgNavi = [[LightNavigationController alloc] initWithRootViewController:msg];
    
    
    CPYViewController *cpy = [[CPYViewController alloc]init];
    
    LightNavigationController *cpyNavi = [[LightNavigationController alloc] initWithRootViewController:cpy];
    
    
    LoveViewController *love = [[LoveViewController alloc]init];
    LightNavigationController *loveNavi = [[LightNavigationController alloc] initWithRootViewController:love];

    
    self.viewControllers = [NSArray arrayWithObjects:indexNavi,msgNavi,cpyNavi,loveNavi, nil];
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
//    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    // 对item设置相应地图片
    item0.image = [[UIImage imageNamed:@"home_32_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.selectedImage = [[UIImage imageNamed:@"home_32_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = @"首页";
    
    item1.image = [[UIImage imageNamed:@"msg_32_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.selectedImage = [[UIImage imageNamed:@"msg_32_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"消息";
    
    item2.image = [[UIImage imageNamed:@"same_32_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.selectedImage = [[UIImage imageNamed:@"same_32_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.title = @"求同";
    
    item3.image = [[UIImage imageNamed:@"love_32_defalut"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.selectedImage = [[UIImage imageNamed:@"love_32_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.title = @"求爱";
    
//    item4.image = [[UIImage imageNamed:@"knowledge_32_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
//    item4.selectedImage = [[UIImage imageNamed:@"knowledge_32_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item4.title = @"求知";

}

- (void)setBadege:(NSInteger)value andControlellerIndex:(NSInteger)controllerIndex{

    [self.tabBar.items[controllerIndex] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)value]];
}


@end
