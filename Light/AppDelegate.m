//
//  AppDelegate.m
//  Light
//
//  Created by FLY on 15/6/14.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AppDelegate.h"
#import "LightIntroViewController.h"
#import "LightBaseTabBarController.h"
#import <SMS_SDK/SMS_SDK.h>
#import <RongIMKit/RongIMKit.h>
#import "LightLoginNewViewController.h"
#import "LightNavigationController.h"
#import <PKRevealController.h>
#import "IndexLeftViewController.h"
#import "LightNavigationController.h"
#import "IndexMainViewController.h"
#import "LightIntroManager.h"
#import <RongIMKit/RongIMKit.h>
#import "LightRongYunManager.h"
#import "ChatListViewController.h"
#import "AppInfo.h"
#import "APService.h"
#import "UIView+Hud.h"
#import "LightPushCenter.h"
#import "LightUser+Login.h"


#define LightKey @"93cfed023500" 
#define LightSecret  @"1d831db03ca4cfbb26630d846fd9d468"

#define RONGCLOUD_IM_APPKEY @"6tnym1brnsdi7"//@"pwe86ga5elcq6"
#define kDeviceToken @"kDeviceToken"
#define JPushKey @"963d312127bc743b25d0dd2b"



@interface AppDelegate ()<PKRevealing,UITabBarControllerDelegate>

{
    LightBaseTabBarController *mainVC;
    LightPushCenter *pushCenter;
}

@end

@implementation AppDelegate{
    
    UITabBarController *main;
    CGRect barRect;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Mob短信验证SDK初始化
    [SMS_SDK registerApp:LightKey withSecret:LightSecret];
    
//    NSString *_deviceTokenCache = [[NSUserDefaults standardUserDefaults]objectForKey:kDeviceToken];
    
    //初始化融云SDK，
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    
#ifdef __IPHONE_9_0
    // 在 iOS 9 下注册苹果推送，申请推送权限。
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    // 注册苹果推送，申请推送权限。
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif

    
    //windows初始化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    UIViewController *vc = [[UIViewController alloc]initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
    
    if ([LightIntroManager isShowIntro]) {
        
         [self toIntro];
    }
    else
    {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"login"])
        {
            NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
            NSString *email = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
            NSString *pwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
            
            NSString *account = phone?phone:email;
           
            [[LightUser new] loginWithCode:account andPassword:pwd andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
                
                if (isSuccess) {
                    
                    [self toMain];
                }
                else{
                
                    [self toLogin];
                }
            }];
            
            
        }
        else{
            
            [self toLogin];
        }
    }
    [APService setupWithOption:launchOptions];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    UIViewController *vc = [[UIViewController alloc]initWithNibName:nil bundle:nil];
//    self.window.rootViewController = vc;
    
    pushCenter = [LightPushCenter shareCenter];
    
    
    return YES;
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // Register to receive notifications.
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    // Handle the actions.
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
    
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#endif
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    
    [pushCenter receiveRemoteNotification:userInfo];
}
// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 设置 deviceToken。
    NSString *pushToken = [[[[deviceToken description]
                             
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:pushToken];
    [APService registerDeviceToken:deviceToken];
    NSLog(@"获取苹果推送权限成功。");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)toIntro
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    LightIntroViewController *intro = [[LightIntroViewController alloc]init];
    self.window.rootViewController = intro;
    
}


-(void)toLogin {
    
    LightLoginNewViewController *loginViewController=[[LightLoginNewViewController alloc]initWithNibName:@"LightLoginNewViewController" bundle:nil] ;
    
    self.window.rootViewController = [[LightNavigationController alloc]initWithRootViewController:loginViewController];
    
}


-(void)toMain{
    
    mainVC = [[LightBaseTabBarController alloc]init];
    mainVC.delegate = self;
    // Step 1: Create your controllers.
    IndexLeftViewController *leftViewController = [[IndexLeftViewController alloc] init];
    leftViewController.view.backgroundColor = [UIColor lightGrayColor];
    
    UINavigationController *leftNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    
    
    // Step 2: Instantiate.
    self.revealController = [PKRevealController revealControllerWithFrontViewController:mainVC
                                                                     leftViewController:leftNavigationController];
    // Step 3: Configure.
    self.revealController.delegate = self;
    self.revealController.animationDuration = 0.25;
    
    [self.revealController setMinimumWidth:240 maximumWidth:WINSIZE.width forViewController:leftNavigationController];

    [self.window setRootViewController:self.revealController];
    
}

- (void)resetRevealController
{
    [self.revealController setFrontViewController:mainVC];
    [self.revealController showViewController:self.revealController.leftViewController];
}



- (void)showCenter
{
    [self.revealController showViewController:self.revealController.frontViewController animated:YES completion:^(BOOL finished) {
        
    }];
}
- (void)showLeftOrCenter
{
    
    if (self.revealController.state ==PKRevealControllerShowsLeftViewController ) {
        
        [self.revealController showViewController:self.revealController.frontViewController animated:YES completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [self.revealController showViewController:self.revealController.leftViewController animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
}
#pragma mark -- tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    LightNavigationController *navi = (LightNavigationController *)viewController;
    
    if ([navi.viewControllers[0] isKindOfClass:[IndexMainViewController class]]) {
        
        self.revealController.recognizesPanningOnFrontView = YES;
        
    }
    else{
        
        if ([navi.viewControllers[0] isKindOfClass:[ChatListViewController class]]) {
            
        }
        self.revealController.recognizesPanningOnFrontView = NO;
    }
}
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
//{
//    
//}

/*
-(void)dealloc
{
    [main release];
    [self.window release];
    [super dealloc];
}
 */


@end
