//
//  KBWarReportModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBWarReportModel.h"


@implementation KBMidWarReportModel


@end

@implementation KBWarReportModel
@dynamic data;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [KBMidWarReportModel class]};
}

@end
