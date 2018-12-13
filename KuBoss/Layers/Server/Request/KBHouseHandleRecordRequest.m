//
//  KBHouseHandleRecordRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseHandleRecordRequest.h"

@implementation KBHouseHandleRecordRequest
- (NSString *)baseRequestUrl
{
    return @"/task/getHousingCirculationRecord";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}
@end
