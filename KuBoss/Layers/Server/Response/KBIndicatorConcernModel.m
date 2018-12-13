//
//  KBIndicatorConcernModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBIndicatorConcernModel.h"

@implementation KBBottomIndicatorConcernModel

@end

@implementation KBMidIndicatorConcernModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"targetlist" : [KBBottomIndicatorConcernModel class]};
}

@end

@implementation KBIndicatorConcernModel
@dynamic data;

@end
