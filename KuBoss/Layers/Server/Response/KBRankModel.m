//
//  KBRankModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankModel.h"



@implementation KBMidRankModel

@end

@implementation KBRankModel
@dynamic data;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [KBMidRankModel class]};
}


@end
