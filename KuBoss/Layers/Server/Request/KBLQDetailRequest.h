//
//  KBLQDetailRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBLQDetailRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                      timetype:(NSInteger)timetype
                       agentid:(NSInteger)agentid;

@end
