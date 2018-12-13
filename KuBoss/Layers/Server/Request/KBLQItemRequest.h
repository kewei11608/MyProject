//
//  KBLQItemRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBLQItemRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid  agentid:(NSInteger)agentid lowquantificationrid:(NSInteger)lowquantificationrid;

@end
