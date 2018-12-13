//
//  KBRankRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

// 排行榜
@interface KBRankRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                     tradeType:(NSInteger)tradetype
                          page:(NSInteger)page
                          size:(NSInteger)size
                         month:(NSString *)month;

@end
