//
//  KBFreezeRecordDetailsRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFreezeRecordDetailsRequest.h"
@interface KBFreezeRecordDetailsRequest()
@property (nonatomic,copy) NSString * approvaid;

@end
@implementation KBFreezeRecordDetailsRequest

- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSString *)approvaid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.approvaid = approvaid;
    return self;
}
- (NSString *)baseRequestUrl
{
    
    return @"/task/getAccountFreezeRecordDetails";
}


- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid,
             @"approvaid":self.approvaid
             };
}
@end
