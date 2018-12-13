//
//  KBJPushRegistRequest.h
//  KuBoss
//
//  Created by risenb_mac on 2018/6/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBJPushRegistRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid registID:(NSString *)registID;

@end
