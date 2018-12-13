//
//  AppDelegate.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Router.h"
#import "KBRootViewController.h"
#import "KBMineViewController.h"
#import "KBGlobalControllerCenter.h"
#import "YTKNetwork.h"
#import <UMAnalytics/MobClick.h>
#import <WXApi.h>
#import <JPUSHService.h>
#import "KBDetailMessageViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UMCommon/UMCommon.h>

// 测试
//#define KBOSS_AppKey @"9ec6708fc182f86fa3a22b8f"
//#define KBOSS_MasterSecret @"64eeb405bdef7655bc639cc9"
// 线上
#define KBOSS_AppKey @"f003297eeafb1137d975e61d"
#define KBOSS_MasterSecret @"fa226d5d5dc66e2cf0246aae"

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[self registerRounter];
    [self initRootViewController];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = httpApi;
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",
                     @"image/jpeg",
                     @"image/png",
                     @"application/octet-stream", nil]
         forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];

    [UMConfigure initWithAppkey:@"5b189b3ff43e4840ae000041" channel:@"App Store"];
    [UMConfigure setEncryptEnabled:YES];
    [MobClick setScenarioType:E_UM_DPLUS];
    
    [WXApi registerApp:@"wxcf1e326424271ecc" enableMTA:NO];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:KBOSS_AppKey channel:@"APP Store" apsForProduction:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSDictionary *pushNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (pushNotification) {
        [self clickNoti:pushNotification];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (registrationID) {
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"JPushRegistrationID"];
        }
    }];
}

- (void)initRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    KBRootViewController * rootVC =  [[KBRootViewController alloc] init];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    KBMineViewController *mineVC  = [[KBMineViewController alloc]init];
    UINavigationController *mineNavigationController = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                            initWithCenterViewController:rootNavigationController leftDrawerViewController:mineNavigationController];
    drawerController.maximumLeftDrawerWidth =[[UIScreen mainScreen] bounds].size.width*0.8;
    self.window.rootViewController = drawerController;
    [KBGlobalControllerCenter sharedInstance].mmDrawerController = drawerController;
    [KBGlobalControllerCenter sharedInstance].mmDrawerController.openDrawerGestureModeMask =  MMOpenDrawerGestureModeNone;
    [KBGlobalControllerCenter sharedInstance].mmDrawerController.closeDrawerGestureModeMask =  MMOpenDrawerGestureModeAll;
    [self.window makeKeyAndVisible];
  
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return [WXApi handleOpenURL:url delegate:self];
}



-(void)onReq:(BaseReq *)req {
    
    
}
// 从微信分享过后点击返回应用的时候调用
- (void)onResp:(BaseResp *)resp {
    
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    if (sendResp.errCode == WXSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WXShareSuccess" object:@"WXShare"];
    }
    //使用UIAlertView 显示回调信息
//    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [alertview show];
//    /*  WXSuccess           = 0,    /**< 成功    */
//    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
//    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
//    WXErrCodeSentFail   = -3,   /**< 发送失败    */
//    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
//    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
//    */
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self clickNoti:userInfo];
    completionHandler();  // 系统要求执行这个方法
}

- (void)clickNoti:(NSDictionary *)userInfo {
    MMDrawerController *DC = self.window.rootViewController;
    UINavigationController *nvc = DC.centerViewController;
    //    KBDetailMessageViewController *vc = [[KBDetailMessageViewController alloc] initMessageId:@"" type:@""];
    //    [(UINavigationController *)DC.centerViewController pushViewController:vc animated:YES];
    
    if ([userInfo[@"MessageTypeCode"] isEqualToString:@"KUBOSS.BUSINESS"])
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeBusinessMessage]){
            [nvc pushViewController:[NSClassFromString(@"KBModulesMessageViewController") new] animated:YES];
        }
        
    }
    else if ([userInfo[@"MessageTypeCode"] isEqualToString:@"KUBOSS.SITE"])
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeSiteMessage]){
            [nvc pushViewController:[NSClassFromString(@"KBStationMessageViewController") new] animated:YES];
        }
        
    }
    else if ([userInfo[@"MessageTypeCode"] isEqualToString:@"KUBOSS.SYSTEM"])
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeSystemMessage]){
            [nvc pushViewController:[NSClassFromString(@"KBSystemMessageViewController") new] animated:YES];
        }
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
