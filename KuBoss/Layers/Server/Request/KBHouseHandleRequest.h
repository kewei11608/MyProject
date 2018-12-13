//
//  KBHouseHandleRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBHouseHandleRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid
                     approvaid:(NSString *)approvaid
                  decisiontype:(NSInteger)decisiontype
                         input:(NSString *)input;
@end
