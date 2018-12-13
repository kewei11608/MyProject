//
//  KBEDRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBEDRequest.h"
@interface KBEDRequest ()
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger agentid;
@property (nonatomic,assign) NSInteger page;

@end
@implementation KBEDRequest

- (instancetype)initWithUserid:(NSString *)userid
                          type:(NSInteger)type
                       agentid:(NSInteger)agentid
                          page:(NSInteger)page
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.type = type;
    self.agentid = agentid;
    self.page = page;

    
    return self;
}


- (NSString *)baseRequestUrl
{
    return @"/bmac/yryselect";
}

- (id)baseRequestArgument
{
    return @{@"type":@(self.type),@"agentid":@(self.agentid),@"userid":self.uid,@"page":@(self.page)};
}


@end
