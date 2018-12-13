//
//  KBModifyPhoneRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModifyPhoneRequest.h"
@interface KBModifyPhoneRequest ()
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *phone;

@end
@implementation KBModifyPhoneRequest

- (instancetype)initWithUserid:(NSString *)userid
                      password:(NSString *)password
                          code:(NSString *)code
                        iphone:(NSString *)iphone
{
    self  = [super initWithUserid:userid];
    if (!self) return nil;
    self.password = password;
    self.code = code;
    self.phone = iphone;
    return self;
}


- (NSString *)baseRequestUrl
{
    return @"/user/modifyPhone";
}

- (id)baseRequestArgument
{
    return  @{@"userid":self.uid,
              @"password":self.password,
              @"code":self.code,
              @"phone":self.phone
              };
}

@end
