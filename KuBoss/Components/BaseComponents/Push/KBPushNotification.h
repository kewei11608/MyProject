//
//  KSYPushNotification.h
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KBPushNotification : NSObject


+ (void)replyPushNotificationAuthorization:(UIApplication *)application parent:(id)parent;


//定时推送
+ (void)createLocalizedUserNotification;

@end
