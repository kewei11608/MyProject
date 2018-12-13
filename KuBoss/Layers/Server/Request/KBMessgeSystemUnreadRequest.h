//
//  KBMessgeSystemUnreadRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBMessgeSystemUnreadRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                      areaCode:(NSInteger) code;

@end
