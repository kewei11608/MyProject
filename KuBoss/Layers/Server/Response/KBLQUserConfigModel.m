//
//  KBLQUserConfigModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQUserConfigModel.h"

@implementation KBLQConfigModel

@end
@implementation KBLQUserShopModel

@end
@implementation KBMidLQUserConfigModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"mdxx" : [KBLQUserShopModel class],@"dlhbz":[KBLQConfigModel class]};
}
@end
@implementation KBLQUserConfigModel

@synthesize data;

@end
