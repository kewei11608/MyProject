//
//  KBAccountFreezeListModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAccountFreezeListModel.h"

@implementation KBAccountFreezeModel


@end

@implementation KBAccountFreezeListData
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"freezeList" : [KBAccountFreezeModel class],@"arrays" : [KBAccountFreezeModel class]};
}


@end

@implementation KBAccountFreezeListModel

@dynamic data;

@end
