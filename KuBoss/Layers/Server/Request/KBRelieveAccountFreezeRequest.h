//
//  KBRelieveAccountFreezeRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBRelieveAccountFreezeRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid accountid:(NSInteger)accountid;

@end
