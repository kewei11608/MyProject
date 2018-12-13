//
//  KBBannerRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBannerRequest.h"

@implementation KBBannerRequest


- (NSString *)baseRequestUrl
{
    return @"/hc/hcselect";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid};
}

@end
