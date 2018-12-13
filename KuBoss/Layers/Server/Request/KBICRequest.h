//
//  KBIndicatorConcernRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

// 获取指标关注

@interface KBICRequest : KBBaseRequest
// 传入0查询登录人关注的3个指标，传入1查询所有指标
- (instancetype)initWithUserid:(NSString *)userid checkType:(NSInteger)type;


@end
