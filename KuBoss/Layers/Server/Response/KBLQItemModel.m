//
//  KBLQItemModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQItemModel.h"

@implementation KBLQItemSub

@end
@implementation KBLQItemData
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"grdlhsj" : [KBLQItemSub class]};
}

@end
@implementation KBLQItemModel
@synthesize data;
@end
