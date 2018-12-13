//
//  GlobalControllerCenter.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBGlobalControllerCenter.h"
#import "KBStartPageView.h"
#import "AppDelegate.h"
#import "KBUserDefaultLayer.h"
#import "KBLoginViewController.h"
#import "NSObject+KBHelper.h"

static NSString * KBShowStartView = @"KBShowStartView";
static NSString * KBShowLoginView = @"KBShowLoginView";

static KBGlobalControllerCenter *instance = nil;

@interface KBGlobalControllerCenter();
@property (nonatomic,strong) KBStartPageView *startPageView;

@end
@implementation KBGlobalControllerCenter

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[KBGlobalControllerCenter alloc]init];
        }
    });
    return instance;
}

- (void)showStartView
{
    if (![KBUserDefaultLayer getBoolUserDefault:KBShowStartView]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.startPageView];
        [KBUserDefaultLayer setBoolUserDefault:KBShowStartView];
    }
}

- (KBStartPageView *)startPageView
{
    if (!_startPageView) {
        _startPageView = [[KBStartPageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        
    }
    return _startPageView;
}

- (void)showLoginView
{

    if (![KBUserInfoModel isLogin]) {
        [self kb_presentVC:[KBLoginViewController new] animated:NO];
    }
}

- (void)pushMineMode:(KBNavgationMode )navgationMode
{
     [[KBGlobalControllerCenter sharedInstance].mmDrawerController closeDrawerAnimated:NO completion:nil];
    
    switch (navgationMode) {
        case KBNavgationModeSetting:
            [self.rootNav pushViewController:[NSClassFromString(@"KBSettingViewController") new] animated:YES];
            break;
        case KBNavgationModeFeedback:
            [self.rootNav pushViewController:[NSClassFromString(@"KBFeedBackViewController") new] animated:YES];
            break;
        case KBNavgationModeAbout:
            [self.rootNav pushViewController:[NSClassFromString(@"KBAboutViewController") new] animated:YES];
            break;
            
        default:
            break;
    }
}

- (void)popMineMode:(KBNavgationMode )navgationMode
{
    
    [self.rootNav popToRootViewControllerAnimated:NO];
    [KBGlobalControllerCenter sharedInstance].isClick  = YES;
    [[KBGlobalControllerCenter sharedInstance].mmDrawerController openDrawerSide:MMDrawerSideLeft animated:NO completion:nil];

}


@end
