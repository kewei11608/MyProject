//
//  KBHouseDeatailRequst.h
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBHouseDetailRequst : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSString*)approvaid;
@end
