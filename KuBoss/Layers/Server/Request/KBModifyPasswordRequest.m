//
//  KBModifyPasswordRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModifyPasswordRequest.h"
@interface KBModifyPasswordRequest ()

@property (nonatomic,copy) NSString *pwdOld;
@property (nonatomic,copy) NSString *pwdNew;

@end

@implementation KBModifyPasswordRequest

- (instancetype)initWithUserid:(NSString *)userid
                   oldPassword:(NSString *)pwdOld
                   newPassword:(NSString *)pwdNew
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.pwdOld = pwdOld;
    self.pwdNew = pwdNew;
    
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/user/modifyPassword";
}

- (id)baseRequestArgument
{
    return  @{@"userid":self.uid,
              @"pwdOld":self.pwdOld,
              @"pwdNew":self.pwdNew
              };
}

@end
