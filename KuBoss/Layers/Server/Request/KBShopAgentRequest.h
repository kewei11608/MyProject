//
//  KBShopAgentRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBShopAgentRequest : KBBaseRequest

/*获取门店人员二手房昨天数据
 timetype  昨天（1），周（2），月（3）
 daterange  昨天（本周、本月）：1，一周前（一月前）：2，两周前（两月前）：3，三周前（三月前）：4
 housingtype 二手房（1），租房（2），新房（3）
 
 */

- (instancetype)initWithUserid:(NSString *)userid
                       agentid:(NSInteger) agentid
                      timetype:(NSInteger) timetype
                     daterange:(NSInteger)daterange
                   housingtype:(NSInteger)housingtype;

@end
