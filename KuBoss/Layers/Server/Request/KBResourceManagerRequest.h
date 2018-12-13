//
//  KBResourceManagerRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"
// 资源管理
@interface KBResourceManagerRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid officeid:(NSString *)officeid;
@end
