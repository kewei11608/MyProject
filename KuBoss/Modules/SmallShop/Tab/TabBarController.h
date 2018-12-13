//
//  TabBarController.h
//  bbkm
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabBarController : UITabBarController <UITabBarControllerDelegate, UITabBarDelegate>
{

    
}
- (void)getJPush:(NSDictionary *)userInfo;

- (void)showAlertControllerLogin;

- (void)showAlertControllerFlag:(NSString *)flag Link:(NSString *)link content:(NSString *)content;
// 魔窗跳转
- (void)getMWPushDic:(NSDictionary *)dic;

// 跳转到客服
-(void)pushintoCustomerService;

// 投注记录
-(void)pushintoBettingrecord;
//返回首页
-(void)backhomeVc;


//隐藏悬浮球
-(void)HiddenDragButton:(BOOL)ishidden;

/************环信*************/

// 接收环信聊天的推送
- (void)didReceiveHandleNotification:(NSDictionary *)userInfo;

// 统计未读消息数
-(void)setupUnreadMessageCount;

@end
