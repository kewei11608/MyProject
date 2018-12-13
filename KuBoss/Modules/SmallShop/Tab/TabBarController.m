//
//  TabBarController.m
//  bbkm
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//
#import "TabBarController.h"
#import <objc/runtime.h>
#import "NavViewController.h"
#import "HousingDetailsController.h"
#import "SmallShopController.h"

#import "NavViewController.h"
#import "HousingListController.h"
#import "CustomerController.h"
#import "SettingController.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";

static TabBarController *single = nil;
@interface TabBarController()


@end

@implementation TabBarController

#pragma mark - 创建单例控制器
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [super allocWithZone:zone];
    });
    return single;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"微店" image:[[UIImage imageNamed:@"tab_icon_one"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_icon_one_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.tag = 1;
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"房源" image:[[UIImage imageNamed:@"tab_icon_two"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_icon_two_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item2.tag = 2;
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"客源" image:[[UIImage imageNamed:@"tab_icon_three"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_icon_three_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item3.tag = 3;
    
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"设置" image:[[UIImage imageNamed:@"tab_icon_four"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_icon_four_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item4.tag = 4;
    
    SmallShopController *homeVC = [[SmallShopController alloc] init];
    homeVC.tabBarItem = item1;
    
  
    NavViewController *homeNav = [[NavViewController alloc] initWithRootViewController:homeVC];
    
    HousingListController *BetHallVC = [[HousingListController alloc] init];
    BetHallVC.tabBarItem = item2;
    NavViewController *BetHallNav = [[NavViewController alloc] initWithRootViewController:BetHallVC];
    
    CustomerController *LotteryVC = [[CustomerController alloc] init];
    LotteryVC.tabBarItem = item3;
    
    
    NavViewController *LotteryNav = [[NavViewController alloc] initWithRootViewController:LotteryVC];
    SettingController *myVC = [[SettingController alloc] init];
    myVC.tabBarItem = item4;
    NavViewController *myNav = [[NavViewController alloc] initWithRootViewController:myVC];
    
    @KBWeakObj(self);
    homeVC.backtabar = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    BetHallVC.backtabar = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    LotteryVC.backtabar = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    myVC.backtabar = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
    self.viewControllers = @[homeNav,BetHallNav,LotteryNav,myNav];
    self.delegate = self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName :NavTitleColor} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName :kMainColor}forState:UIControlStateSelected];

//    [self addLeftItem];
    
}
- (void)addLeftItem
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 0, 44, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_return_icon"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(-6,(44 - 30) / 2.0, 21, 30);
    arrow.backgroundColor = [UIColor clearColor];
    
    
    
    [left addSubview:arrow];
   
    [self.view addSubview:left];
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)timerOpenTimer{
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)backhomeVc{
    NSArray *viewControllers = self.viewControllers;
    NavViewController *navVc = viewControllers[self.selectedIndex];
    NSArray *navSubVcs = navVc.viewControllers;
    UIViewController *startVC = (UIViewController *)(navSubVcs.lastObject);
    
    startVC.tabBarController.selectedIndex = 0;
    [startVC.navigationController popToRootViewControllerAnimated:YES];
    
}







@end
