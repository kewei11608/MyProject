//
//  KBPermissionModel.m
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBPermissionModel.h"


@implementation KBPermission


@end
@implementation KBPermissionData
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"auth" : [KBPermission class]};
}

@end
@implementation KBPermissionModel
@synthesize data;
@end

