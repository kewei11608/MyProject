//
//  KBLoginRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLoginRequest.h"
@interface KBLoginRequest()

@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *userCode;

@end
@implementation KBLoginRequest

- (instancetype)initWithUserid:(NSString *)userid
                      userCode:(NSString *)userCode
                      password:(NSString *)password
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.userCode = userCode;
    self.password = password;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/login/loginValidate";
}

- (id)baseRequestArgument
{
    return  @{@"userid":self.userCode,@"password":self.password};
}

@end
