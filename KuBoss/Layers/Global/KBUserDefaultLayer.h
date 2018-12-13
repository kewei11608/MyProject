//
//  KBUserDefaultLayer.h
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBUserDefaultLayer : NSObject

+ (void)setBoolUserDefault:(NSString *)key;

+ (BOOL)getBoolUserDefault:(NSString *)key;

+ (void)setLeftFilterDate:(NSString *)filterData;

+ (NSString *)getLeftFilterDate;

+ (void)setRightFilterDate:(NSString *)filterData;

+ (NSString *)getRightFilterDate;

+ (void)setVauleFilterDate:(NSString *)filterData;

+ (NSString *)getVauleFilterDate;

+ (void)setTypeFilterDate:(NSString *)filterData;

+ (NSString *)getTypeFilterDate;

+ (void)setFilterHouseType:(NSString *)filterData;

+ (NSString *)getFilterHouseType;

@end
