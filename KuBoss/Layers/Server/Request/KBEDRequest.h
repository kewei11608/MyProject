//
//  KBEDRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"
//业务管理-人员信息-员工动态
@interface KBEDRequest : KBBaseRequest

// type 0是查询四条数据 1是查询以十条数据为一页分页查询（隐藏参数页数）
- (instancetype)initWithUserid:(NSString *)userid
                          type:(NSInteger)type
                       agentid:(NSInteger)agentid
                          page:(NSInteger)page;


@end
