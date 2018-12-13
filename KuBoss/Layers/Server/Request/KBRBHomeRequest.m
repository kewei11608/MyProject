//
//  KBRBHomeRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRBHomeRequest.h"
@interface KBRBHomeRequest ()
@property (nonatomic,assign) NSInteger timeType;
@property (nonatomic,assign) NSInteger dataRange;
@property (nonatomic,assign) NSInteger housingType;

@end
@implementation KBRBHomeRequest

- (instancetype)initWithUserid:(NSString *) userid
                      timeType:(NSInteger) timeType
                     dataRange:(NSInteger) dataRange
                   housingType:(NSInteger) housingType
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.timeType = timeType;
    self.dataRange = dataRange;
    self.housingType = housingType;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/bmac/syhzsjzselect";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid,
             @"timetype":@(self.timeType),
             @"daterange":@(self.dataRange),
             @"housingtype":@(self.housingType)
             };
}

@end
