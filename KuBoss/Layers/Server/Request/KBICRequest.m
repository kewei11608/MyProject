//
//  KBIndicatorConcernRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBICRequest.h"
@interface KBICRequest()

@property (nonatomic,assign) NSInteger checkType;

@end
@implementation KBICRequest


- (instancetype)initWithUserid:(NSString *)userid checkType:(NSInteger )type
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.checkType = type;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/tac/iocserviceselect";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid,@"isCheckAll":@(self.checkType)};
}

@end
