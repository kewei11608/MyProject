//
//  KBResourceManagerModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBResourceManagerModel.h"


@implementation KBGgmdimModel


@end

@implementation KBSymdxxzhModel


@end

@implementation KBMidResourceManagerModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"mdxxzh" : [KBSymdxxzhModel class],@"ggmdim" : [KBGgmdimModel class]};
}

@end

@implementation KBResourceManagerModel
@dynamic data;

@end
