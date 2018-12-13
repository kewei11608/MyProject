//
//  KBLQRootRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQRootRequest.h"
@interface KBLQRootRequest ()
@property (nonatomic,assign) NSInteger timetype;

@end
@implementation KBLQRootRequest

- (instancetype)initWithUserid:(NSString *)userid  timetype:(NSInteger) timetype
{
    self = [super initWithUserid:userid];
    if (!self) return  nil;
    self.timetype = timetype;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/lqcc/dlhyj";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"timetype":@(self.timetype)};
}
@end
