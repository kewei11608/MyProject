//
//  KBRBHomeRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBRBHomeRequest : KBBaseRequest

/*
 timeType   昨天（1），周（2），月（3）
 dataRange 昨天（本周、本月）：1，一周前（一月前）：2，两周前（两月前）：3，三周前（三月前）：4
 housingType  二手房（1），租房（2），新房（3）
 
 */
- (instancetype)initWithUserid:(NSString *) userid
                      timeType:(NSInteger) timeType
                     dataRange:(NSInteger) dataRange
                   housingType:(NSInteger) housingType;

@end
