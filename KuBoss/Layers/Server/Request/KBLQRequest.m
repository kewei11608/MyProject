//
//  KBLQRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQRequest.h"
@interface KBLQRequest ()
@property (nonatomic,copy) NSString *agentid;

@end
@implementation KBLQRequest

- (instancetype)initWithUserid:(NSString *)userid agentid:(NSString *)agentid
{
    self  = [super initWithUserid:userid];
    if (!self) return nil;
    self.agentid = agentid;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/lqcc/lqcczybselect";
}


- (id)baseRequestArgument
{
    return @{@"agentid":self.agentid,@"userid":self.uid};
}

@end
