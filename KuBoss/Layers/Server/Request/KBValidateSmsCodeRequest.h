//
//  KBValidateSmsCodeRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBValidateSmsCodeRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                      password:(NSString *)password
                          code:(NSString *)code;

@end
