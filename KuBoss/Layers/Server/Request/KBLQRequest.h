//
//  KBLQRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"
// 业务管理-人员信息-低量化记录

@interface KBLQRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid agentid:(NSString *)agentid;

@end
