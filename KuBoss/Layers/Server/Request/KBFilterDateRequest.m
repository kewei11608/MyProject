//
//  KBFilterDateRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/14.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFilterDateRequest.h"
@interface KBFilterDateRequest()

@end
@implementation KBFilterDateRequest

- (NSString *)baseRequestUrl
{
    return @"/bmac/rqxxselect";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid};
}


@end
