//
//  AppDelegate+Router.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AppDelegate+Router.h"

@implementation AppDelegate (Router)

- (void)registerRounter
{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[KBRouter sharedInstance] map:kRounterWarMoreKey toControllerClass:NSClassFromString(@"KBWarMoreViewController")];
        
        [[KBRouter sharedInstance] map:kRounterRankKey toControllerClass:NSClassFromString(@"KBRankViewController")];
    });

    
    
}
@end
