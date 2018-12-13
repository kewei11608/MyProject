//
//  KBUserBehavior.m
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBUserBehavior.h"
#import <UMAnalytics/MobClick.h>
#import <UMAnalytics/DplusMobClick.h>


@implementation KBUserBehavior

+ (void)behaviorEventId:(NSString *)eventId
{
//    [MobClick event:eventId];
    [DplusMobClick track:eventId];
}
@end
