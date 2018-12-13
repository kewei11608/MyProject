//
//  KBShopModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShopModel.h"

@implementation KBShopModel
@dynamic data;

@end


@implementation KBMidShopModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"zrzsj" : [KBShopTotalModel class], @"ggmdlist" : [KBAgenListModel class],@"ggmdim":[KBGgmdimModel class]};
}
@end

@implementation KBShopTotalModel

@end

@implementation KBAgenListModel

@end

