//
//  KBHousingCirculationDone.m
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHousingCirculationDoneRequest.h"
@interface KBHousingCirculationDoneRequest()
@property (nonatomic,copy) NSString * approvaid;
@end

@implementation KBHousingCirculationDoneRequest
- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSString *)approvaid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.approvaid = approvaid;
    return self;
}
- (NSString *)baseRequestUrl
{
    
    return @"/task/getHousingCirculationdone";
}


- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid,
             @"approvaid":self.approvaid
             };
}

@end
