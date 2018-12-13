//
//  KBCheckVersionRequest.m
//  KuBoss
//
//  Created by 游溟 on 2018/9/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBCheckVersionRequest.h"

@implementation KBCheckVersionRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"";
}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodPOST;
}

- (id)baseRequestArgument
{
    
    return @{};
}

@end
