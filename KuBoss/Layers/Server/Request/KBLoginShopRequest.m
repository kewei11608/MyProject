//
//  KBLoginShopRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLoginShopRequest.h"

@implementation KBLoginShopRequest


- (NSString *)baseRequestUrl
{
    return @"/login/getOfficeByUser";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"areaCode":[KBUserInfoModel areaCode]};
}

@end
