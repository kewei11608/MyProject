//
//  KBRoomDetailRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBRoomDetailRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid realtyid:(NSInteger)realtyid;
@end
