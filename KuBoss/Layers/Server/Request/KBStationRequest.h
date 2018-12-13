//
//  KBStationRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/6/2.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBStationRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid
                      areaCode:(NSString *)areaCode
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize;
@end
