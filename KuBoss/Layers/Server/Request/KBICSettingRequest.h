//
//  KBICSettingRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBICSettingRequest : KBBaseRequest

// 指标ID，支持多个ID英文半角“,”如“1，2，3”

- (instancetype)initWithUserid:(NSString *)userid targetType:(NSString *)targetType;

@end

