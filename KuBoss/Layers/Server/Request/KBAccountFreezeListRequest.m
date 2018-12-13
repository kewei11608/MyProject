//
//  KBAccountFreezeListRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAccountFreezeListRequest.h"

@implementation KBAccountFreezeListRequest

- (NSString *)baseRequestUrl
{
    return @"/task/getAccountFreezeList";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}

@end
