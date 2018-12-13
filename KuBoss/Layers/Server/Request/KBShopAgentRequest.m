//
//  KBShopAgentRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShopAgentRequest.h"
@interface KBShopAgentRequest()
@property (nonatomic,assign) NSInteger agentid;
@property (nonatomic,assign) NSInteger timetype;
@property (nonatomic,assign) NSInteger daterange;
@property (nonatomic,assign) NSInteger housingtype;

@end
@implementation KBShopAgentRequest


- (instancetype)initWithUserid:(NSString *)userid
                       agentid:(NSInteger) agentid
                      timetype:(NSInteger) timetype
                     daterange:(NSInteger)daterange
                   housingtype:(NSInteger)housingtype
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.agentid = agentid;
    self.timetype = timetype;
    self.daterange = daterange;
    self.housingtype = housingtype;
    
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/bmac/yrszxselect";
}



- (id)baseRequestArgument
{
    return @{@"userid":self.uid,@"agentid":@(self.agentid),@"timetype":@(self.timetype),@"daterange":@(self.daterange),@"housingtype":@(self.housingtype)};
}
@end
