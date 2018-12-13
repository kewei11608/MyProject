//
//  KBBanerModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBanerModel.h"

@implementation KBBottomBanerModel

@end

@implementation KBMidBanerModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"targetlist" : [KBBottomBanerModel class]};
}
@end

@implementation KBBanerModel
@dynamic data;

@end
