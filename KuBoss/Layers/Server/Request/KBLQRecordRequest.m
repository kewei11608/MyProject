//
//  KBLQRecordRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQRecordRequest.h"

@implementation KBLQRecordRequest


- (NSString *)baseRequestUrl
{
    return @"/lqcc/dlhyjjlselect";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid};
}

@end
