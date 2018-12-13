//
//  KBModifyPasswordRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBModifyPasswordRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                   oldPassword:(NSString *)pwdOld
                   newPassword:(NSString *)pwdNew;

@end