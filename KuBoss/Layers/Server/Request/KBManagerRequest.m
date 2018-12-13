//
//  KBManagerRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/18.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerRequest.h"
@interface KBManagerRequest ()
@property (nonatomic,copy ) NSString *officeid;

@end

@implementation KBManagerRequest

- (instancetype)initWithUserid:(NSString *)userid officeId:(NSString *)officeId
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.officeid = officeId;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/bmac/zyglselectSY";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"officeid":self.officeid};
}

@end
