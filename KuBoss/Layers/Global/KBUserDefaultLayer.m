//
//  KBUserDefaultLayer.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBUserDefaultLayer.h"
#define  kFilterLeftDate  @"kFilterLeftDate"
#define  kFilterRightDate  @"kFilterRightDate"
#define  kFilterVauleDate  @"kFilterVauleDate"
#define  kFilterTypeDate  @"kFilterTypeDate"
#define  kFilterHouseControl  @"kFilterHouseControl"

@interface KBUserDefaultLayer ()

@end
@implementation KBUserDefaultLayer

+ (void)setBoolUserDefault:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolUserDefault:(NSString *)key
{
    return  [[NSUserDefaults  standardUserDefaults] objectForKey:key];
    
}

+ (void)setLeftFilterDate:(NSString *)filterData
{
    [[NSUserDefaults standardUserDefaults]  setObject:filterData forKey:kFilterLeftDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getLeftFilterDate
{
    return [[NSUserDefaults standardUserDefaults]  objectForKey:kFilterLeftDate];
}

+ (void)setRightFilterDate:(NSString *)filterData
{
    [[NSUserDefaults standardUserDefaults]  setObject:filterData forKey:kFilterRightDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getRightFilterDate
{
    return [[NSUserDefaults standardUserDefaults]  objectForKey:kFilterRightDate];
}

+ (void)setVauleFilterDate:(NSString *)filterData
{
    
    [[NSUserDefaults standardUserDefaults]  setObject:filterData forKey:kFilterVauleDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getVauleFilterDate
{
     return [[NSUserDefaults standardUserDefaults]  objectForKey:kFilterVauleDate];
}

+ (void)setTypeFilterDate:(NSString *)filterData
{
    [[NSUserDefaults standardUserDefaults]  setObject:filterData forKey:kFilterTypeDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getTypeFilterDate
{
     return [[NSUserDefaults standardUserDefaults]  objectForKey:kFilterTypeDate];
}

+ (void)setFilterHouseType:(NSString *)filterData
{
    [[NSUserDefaults standardUserDefaults]  setObject:filterData forKey:kFilterHouseControl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getFilterHouseType
{
     return [[NSUserDefaults standardUserDefaults]  objectForKey:kFilterHouseControl];
}

@end
