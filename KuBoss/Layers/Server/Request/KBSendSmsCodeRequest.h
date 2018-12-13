//
//  KBSendSmsCodeRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBSendSmsCodeRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid phone:(NSString *)phone;

@end
