//
//  KBHouseListReuest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseListReuest.h"

@implementation KBHouseListReuest
- (NSString *)baseRequestUrl
{
    return @"/task/getHousingCirculationList";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}
@end
