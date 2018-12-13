//
//  KBLQUserConfigRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQUserConfigRequest.h"

@interface KBLQUserConfigRequest()

@property (nonatomic, copy) NSString *noticetype;

@end

@implementation KBLQUserConfigRequest


- (instancetype)initWithUserid:(NSString *)userid noticetype:(NSString *)noticetype  {
    self = [super initWithUserid:userid];
    if (!self) return nil;
    
    self.noticetype = noticetype;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/lqcc/getLowQuantizationSettingByUserid";
}

- (id)baseRequestArgument
{
    if (self.noticetype) {
        return @{@"userid":self.uid, @"noticetype" : self.noticetype};
    }
    return @{@"userid":self.uid};
}

@end
