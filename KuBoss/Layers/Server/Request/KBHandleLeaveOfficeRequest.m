//
//  KBHandleLeaveOfficeRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHandleLeaveOfficeRequest.h"
@interface KBHandleLeaveOfficeRequest ()
@property (nonatomic,assign) NSInteger accountid;
@end
@implementation KBHandleLeaveOfficeRequest

- (instancetype)initWithUserid:(NSString *)userid accountid:(NSInteger)accountid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.accountid = accountid;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/handleLeaveOffice";
}

- (id)baseRequestArgument
{
    
    return @{@"accountid":@(self.accountid)};
}

@end
