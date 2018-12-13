//
//  KBLQItemRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQItemRequest.h"
@interface KBLQItemRequest ()
@property (nonatomic,assign) NSInteger agentid;
@property (nonatomic,assign) NSInteger lowquantificationrid;

@end
@implementation KBLQItemRequest

- (instancetype)initWithUserid:(NSString *)userid  agentid:(NSInteger)agentid lowquantificationrid:(NSInteger)lowquantificationrid;
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.agentid = agentid;
    self.lowquantificationrid = lowquantificationrid;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/lqcc/mryjxqselect";
    
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"lowquantificationrid":@(self.lowquantificationrid),@"agentid":@(self.agentid)};
}


@end
