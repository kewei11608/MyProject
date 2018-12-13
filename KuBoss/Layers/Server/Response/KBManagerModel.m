//
//  KBManagerModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/18.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerModel.h"

@implementation KBShopListModel


@end
@implementation KBManageListModel


@end
@implementation KBMidManagerModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"symdxxzh" : [KBManageListModel class],@"ggmdim" : [KBShopListModel class]};
}

@end

@implementation KBManagerModel
@synthesize data;

@end

