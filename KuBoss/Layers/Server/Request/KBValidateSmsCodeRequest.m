//
//  KBValidateSmsCodeRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBValidateSmsCodeRequest.h"
@interface KBValidateSmsCodeRequest ()
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *code;

@end
@implementation KBValidateSmsCodeRequest

- (instancetype)initWithUserid:(NSString *)userid
                      password:(NSString *)password
                          code:(NSString *)code
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.password = password;
    self.code  = code;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/user/validateSmsCode";
}

- (id)baseRequestArgument
{
    return  @{@"userid":self.uid,
              @"password":self.password,
              @"code":self.code,
              };
}

@end
