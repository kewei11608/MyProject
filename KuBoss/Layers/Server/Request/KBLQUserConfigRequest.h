//
//  KBLQUserConfigRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBLQUserConfigRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid noticetype:(NSString *)noticetype ;

@end
