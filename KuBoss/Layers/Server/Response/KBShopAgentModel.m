//
//  KBShopAgentModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShopAgentModel.h"

@implementation KBBottomShopAgentModel

@end
@implementation KBMidShopAgentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"zrzsj" : [KBBottomShopAgentModel class]};
}
@end
@implementation KBShopAgentModel
@dynamic data;

@end
