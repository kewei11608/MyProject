//
//  KBResourceManagerRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBResourceManagerRequest.h"
@interface KBResourceManagerRequest ()
@property (nonatomic,copy) NSString *officeid;


@end
@implementation KBResourceManagerRequest

- (instancetype)initWithUserid:(NSString *)userid officeid:(NSString *)officeid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.officeid  = officeid;
    
    return self;
    
}


- (NSString *)baseRequestUrl
{
    return @"/bmac/zyglselectSY";
}


- (id)baseRequestArgument
{
    return @{@"officeid":self.officeid,@"userid":self.uid};
}

@end
