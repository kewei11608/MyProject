//
//  KBModulesRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/6/2.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBModulesRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize;
@end
