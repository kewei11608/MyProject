//
//  KBLQDetailRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQDetailRequest.h"
@interface KBLQDetailRequest ()
@property (nonatomic,assign) NSInteger timetype;
@property (nonatomic,assign) NSInteger agentid;
@end
@implementation KBLQDetailRequest
- (instancetype)initWithUserid:(NSString *)userid
                      timetype:(NSInteger)timetype
                       agentid:(NSInteger)agentid
{
    self = [super initWithUserid:userid];
    if (!self)  return nil;
    self.timetype = timetype;
    self.agentid = agentid;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/lqcc/yjxqselect";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"timetype":@(self.timetype),@"agentid":@(self.agentid)};
}

@end
