//
//  KBSendRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/6/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBSendRequest : KBBaseRequest

- (instancetype) initWithUserid:(NSString *)userid lowId:(NSString *)lowId guidance:(NSString *)guidance;

@end
