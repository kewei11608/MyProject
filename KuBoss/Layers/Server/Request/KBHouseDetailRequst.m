//
//  KBHouseDeatailRequst.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseDetailRequst.h"
@interface KBHouseDetailRequst()
@property (nonatomic,assign) NSString* approvaid;

@end
@implementation KBHouseDetailRequst

- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSString*)approvaid
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
    
    return @{@"userid":self.uid,@"approvaid":self.approvaid};
}
@end
