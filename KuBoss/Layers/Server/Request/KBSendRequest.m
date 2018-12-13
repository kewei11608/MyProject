//
//  KBSendRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSendRequest.h"
@interface KBSendRequest ()

@property (nonatomic,strong) NSString *lowId;
@property (nonatomic, copy) NSString *guidance;

@end
@implementation KBSendRequest
- (instancetype) initWithUserid:(NSString *)userid lowId:(NSString *)lowId guidance:(NSString *)guidance
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    
    self.lowId =lowId;
    self.guidance = guidance;
    return self;
}
- (NSString *)baseRequestUrl
{
    
    return @"/jpush/lmp";
}

- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid,
             @"lowquantificationrid":self.lowId,
             @"guidance" : self.guidance
             };
}

@end
