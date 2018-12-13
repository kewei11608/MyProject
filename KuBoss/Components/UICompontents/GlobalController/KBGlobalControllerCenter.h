//
//  GlobalControllerCenter.h
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMDrawerController/MMDrawerController.h>

typedef NS_ENUM(NSInteger, KBNavgationMode) {
    KBNavgationModeSetting,
    KBNavgationModeFeedback,
    KBNavgationModeAbout,
};

@interface KBGlobalControllerCenter : NSObject
@property (nonatomic,strong) MMDrawerController *mmDrawerController;
@property (nonatomic,strong) UINavigationController *rootNav;
@property (nonatomic,assign)BOOL isClick;

+ (instancetype)sharedInstance;

- (void)showStartView;

- (void)showLoginView;

- (void)pushMineMode:(KBNavgationMode )navgationMode;

- (void)popMineMode:(KBNavgationMode )navgationMode;

@end
