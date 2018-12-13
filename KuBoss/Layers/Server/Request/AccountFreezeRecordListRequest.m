//
//  AccountFreezeRecordListRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AccountFreezeRecordListRequest.h"

@implementation AccountFreezeRecordListRequest
- (NSString *)baseRequestUrl
{
    return @"/task/getAccountFreezeRecordList";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}
@end
