//
//  KBManagerRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/18.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBManagerRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid officeId:(NSString *)officeId;

@end
