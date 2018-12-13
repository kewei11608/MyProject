//
//  KSYHeader.h
//  KSYTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#ifndef KBYHeader_h
#define KBYHeader_h

#import <UIKit/UIKit.h>
#import "UINavigationController+KBHepler.h"
#import "NSObject+KBHelper.h"
#import "UIViewController+KBHelper.h"
#import "KBRouter.h"
#import <Masonry/Masonry.h>
#import "UIView+LayoutMethods.h"
#import "UIView+Shadow.h"
#import "KBUserBehaviorHeader.h"
#import "KBUserBehavior.h"
#import "KBUserDefaultLayer.h"
#import "NSString+TextSize.h"

typedef void (^tellBlock_t)(void);

typedef NS_ENUM(NSInteger, KBModifyViewType) {
    KBModifyViewTypeIphone,
    KBModifyViewTypePassword
};


typedef NS_ENUM(NSInteger, KBModifyIphoneState) {
    KBModifyIphoneStateLoginPassword,
    KBModifyIphoneStateNewNumber,
    KBModifyIphoneStateSuccess
};

typedef NS_ENUM(NSInteger, KBModifyPasswordState) {
    KBModifyPasswordStateStart,
    KBModifyPasswordStateEnd
};

typedef NS_ENUM(NSInteger, KBDateMode) {
    KBDateModeDay = 1,
    KBDateModeWeek,
    KBDateModeMonth,
};

typedef NS_ENUM(NSInteger, KBFollowWithTyp) {
    KBFollowWithTypDefalut = 0,
    KBFollowWithTypAll,
};

typedef NS_ENUM(NSInteger, KBFeedBackMode) {
    KBFeedBackModeNormal = 0,
    KBFeedBackModeAdd,
};


typedef NS_ENUM(NSInteger, KBSheetViewType) {
    KBSheetViewTypeSource,
    KBSheetViewTypeRentType,
    KBSheetViewTypeRenter,
    KBSheetViewTypeSeller,
    KBSheetViewTypeRentUnit
};



#define DEBUGGER 1 //上线版本屏蔽此宏

#ifdef DEBUGGER
/* 自定义log 可以输出所在的类名,方法名,位置(行数)*/
#define KBLog(format, ...) NSLog((@"%s [Line %d] " format), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define KBLog(...)

#endif

#define kDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define kDeviceHeight [[UIScreen mainScreen] bounds].size.height

#define KBWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

#define KBStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define KBCOLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define kMainColor  KBCOLOR_WITH_HEX(0x6B7BFF)
#define blackTextColor          [UIColor colorWithHex:@"#333333"]      //字体黑色
#define grayTextColor           [UIColor colorWithHex:@"#666666"]      //字体灰色
#define LineColor               [UIColor colorWithHex:@"#E1E1E1"]
#define NavColor                [UIColor whiteColor]   // 导航颜色
#define NavTitleColor             [UIColor colorWithHex:@"#281e1e"]    // 导航栏标题颜色



/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#ifdef DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif
#define MSW ([UIScreen mainScreen].bounds.size.width)
#define MSH ([UIScreen mainScreen].bounds.size.height)
//iPhoneX屏幕高度
#define MSXH ([UIScreen mainScreen].bounds.size.height == 812.0 ?[UIScreen mainScreen].bounds.size.height-34 : [UIScreen mainScreen].bounds.size.height)
#define NAVH ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)

#define IPhone4_5_6_6P(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) :(CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ||CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : 0))))
#define IPhone4_5_6_6P_X(a,b,c,d,e) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)?(e) : 0))))

//颜色创建
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]


#define mark router

#define kRounterWarMoreKey   @"RounterWarMoreKey"
#define kRounterRankKey      @"RounterRankKey"

#define kPageSize 20


static NSString * const PermissionCodeBusinessData = @"KuBoss.App.BusinessData";
static NSString * const PermissionCodeBusinessManage = @"KuBoss.App.BusinessManage";
static NSString * const PermissionCodeResourceManage = @"KuBoss.App.ResourceManage";
static NSString * const PermissionCodeLowQuantificationWarning = @"KuBoss.App.LowQuantificationWarning";
static NSString * const PermissionCodeLowQuantificationSet = @"KuBoss.App.QuantificationSet";
static NSString * const PermissionCodeLowQuantificationAnalysis = @"KuBoss.App.QuantificationAnalysis";
static NSString * const PermissionCodeTaskApproval = @"KuBoss.App.TaskApproval";
static NSString * const PermissionCodeHouseCirculation = @"KuBoss.App.HouseCirculation";
static NSString * const PermissionCodeAccountStop = @"KuBoss.App.AccountStop";
static NSString * const PermissionCodeMessage = @"KuBoss.App.Message";
static NSString * const PermissionCodeSiteMessage = @"KuBoss.App.SiteMessage";
static NSString * const PermissionCodeSystemMessage = @"KuBoss.App.SystemMessage";
static NSString * const PermissionCodeBusinessMessage = @"KuBoss.App.BusinessMessage";
static NSString * const PermissionCodeSetup = @"KuBoss.App.Setup";

//#define  httpApi @"http://koobossapi-uat.koofang.com:8080"
//#define  httpApi @"http://kooboss.imwork.net"
#define  httpApi @"http://koobossapi.koofang.com"  //默认API
//#define  httpApi @"http://c21.yl-mall.cn"
//#define  httpFilePath @"/api/app"
#define  httpFilePath @"/kooboss/api/app"

//#define SERVER          @"http://pc123.tg5677.com/"           // 测试
//#define SERVERURL    [NSString stringWithFormat:@"%@api/",SERVER]


#define rsa_publick_key  @"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnWAM9I0TxD0eF0/5ZDZL3rbrz29fFA5+58wCClnsvXwqhLVyQ3W01KvySahlFEFkdHPEpcm/nYcO6d1cC91C7zkKIqoHTavjefMA66UDnZlhO55naL+2/Ky78p1KA3EgAyu1gYIxZhBbbO6BUSd8MvGglGZT9TPTqhRUyJNwmGfU2nCB+4010uq8qUgO14iiN4K8wUQqOuLLnZkLjHzJmv35XLXUbm/XvsYNPktRjK83HpAWmXjViF4NkCblDpKAb7r+RsxP1xXKJgqj86zbPr6ftqLb+B9XoS72hBH2Y3DPA/XsveVlbUchHz+KvljpsFsFOY5Bf8a/cSJQK2wGDwIDAQAB\n-----END PUBLIC KEY-----"

#endif /* KSYHeader_h */
