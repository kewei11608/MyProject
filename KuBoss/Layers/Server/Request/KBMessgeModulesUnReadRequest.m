//
//  KBMessgeModulesUnReadRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBMessgeModulesUnReadRequest.h"
@interface KBMessgeModulesUnReadRequest ()

@end
@implementation KBMessgeModulesUnReadRequest
- (NSString *)baseRequestUrl
{
    return @"/bilist/getbinum";
}


- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid
             };
}


@end
