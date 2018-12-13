//
//  KBHouseHandleRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseHandleRequest.h"
@interface KBHouseHandleRequest ()
@property (nonatomic,assign)NSString * approvaid;
@property (nonatomic,assign)NSInteger decisiontype;
@property (nonatomic,copy)  NSString *input;
@end
@implementation KBHouseHandleRequest

- (instancetype)initWithUserid:(NSString *)userid
                     approvaid:(NSString *)approvaid
                  decisiontype:(NSInteger)decisiontype
                         input:(NSString *)input
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.approvaid = approvaid;
    self.decisiontype = decisiontype;
    self.input = input;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/gethcModifyMissionRefuse";
}

- (id)baseRequestArgument
{
    
    if (!self.input) {
        return @{@"userid":self.uid,@"approvaid":self.approvaid};
    }
    return @{@"userid":self.uid,@"approvaid":self.approvaid,@"completedmemo":self.input};
    
    
}
@end
