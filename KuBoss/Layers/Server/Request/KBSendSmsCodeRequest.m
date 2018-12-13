//
//  KBSendSmsCodeRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSendSmsCodeRequest.h"
@interface KBSendSmsCodeRequest()
@property (nonatomic,copy) NSString *phone;
@end

@implementation KBSendSmsCodeRequest

- (instancetype)initWithUserid:(NSString *)userid phone:(NSString *)phone
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.phone = phone;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/user/sendSmsCode";
}

- (id)baseRequestArgument
{
    return  @{@"phone":self.phone};
}

@end
