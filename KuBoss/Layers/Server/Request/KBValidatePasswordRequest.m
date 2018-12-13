//
//  KBValidatePasswordRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBValidatePasswordRequest.h"

@interface KBValidatePasswordRequest ()
@property (nonatomic,copy) NSString *password;
@end
@implementation KBValidatePasswordRequest

- (instancetype)initWithUserid:(NSString *)userid
                      password:(NSString *)password
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.password = password;
    return self;
    
}

- (NSString *)baseRequestUrl
{
    return @"/user/validatePassword";
}

- (id)baseRequestArgument
{
    
    return   @{@"userid":self.uid,
              @"password":self.password

              };
}

@end
