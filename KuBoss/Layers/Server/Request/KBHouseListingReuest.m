//
//  KBHouseListingReuest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseListingReuest.h"

@implementation KBHouseListingReuest

- (NSString *)baseRequestUrl
{
    return @"/task/getHousingCirculationListing";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}
@end
