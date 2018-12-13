//
//  KBAccountFreezeDetailRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAccountFreezeDetailRequest.h"
@interface KBAccountFreezeDetailRequest ()
@property (nonatomic,assign) NSInteger accountid;
@end
@implementation KBAccountFreezeDetailRequest
- (instancetype)initWithUserid:(NSString *)userid accountid:(NSInteger)accountid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.accountid = accountid;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/getAccountFreezeDetail";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"accountid":@(self.accountid)};
}
@end
