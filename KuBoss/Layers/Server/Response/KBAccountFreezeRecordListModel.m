//
//  AccountFreezeRecordListModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAccountFreezeRecordListModel.h"


@implementation KBAccountFreezeRecordItem

@end
@implementation KBAccountFreezeRecordListData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"oldData" : [KBAccountFreezeRecordItem class],
             @"monthData" : [KBAccountFreezeRecordItem class],
             @"earlier" : [KBAccountFreezeRecordItem class],
             @"nearlyamonth" : [KBAccountFreezeRecordItem class]
             };
}

@end

@implementation KBAccountFreezeRecordListModel
@synthesize data;
@end
