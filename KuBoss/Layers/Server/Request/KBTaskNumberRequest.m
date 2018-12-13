//
//  KBTaskNumberRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/16.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskNumberRequest.h"

@implementation KBTaskNumberRequest


- (NSString *)baseRequestUrl
{
    
    return @"/arac/selectReceiverT";
}

- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid
             };
}

@end
