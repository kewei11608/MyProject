//
//  KBHouseDoneDetailRequst.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseDoneDetailRequst.h"
@interface KBHouseDoneDetailRequst ()
@property (nonatomic,assign) NSInteger approvaid;
@end
@implementation KBHouseDoneDetailRequst
- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSInteger)approvaid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.approvaid = approvaid;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/getHousingCirculationDetails";
}

- (id)baseRequestArgument
{
    
     return @{@"userid":self.uid,@"approvaid":@(self.approvaid)};
}
@end
