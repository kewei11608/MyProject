//
//  KBLoginOutRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLoginOutRequest.h"
@interface KBLoginOutRequest ()

@end
@implementation KBLoginOutRequest

- (NSString *)baseRequestUrl
{
    return @"/login/loginOut";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}

@end
