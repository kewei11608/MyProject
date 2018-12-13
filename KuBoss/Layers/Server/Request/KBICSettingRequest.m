//
//  KBICSettingRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBICSettingRequest.h"
@interface KBICSettingRequest ()
@property (nonatomic,strong) NSString *targetType;

@end
@implementation KBICSettingRequest

- (instancetype)initWithUserid:(NSString *)userid targetType:(NSString *)targetType
{
    self = [super initWithUserid:userid];
    if(!self) return nil;
    self.targetType = @"";
    self.targetType = targetType;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/tac/iocserviceselectsz";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid,@"targettype":self.targetType};
}

@end
