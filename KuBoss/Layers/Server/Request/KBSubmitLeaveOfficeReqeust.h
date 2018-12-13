//
//  KBSubmitLeaveOfficeReqeust.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBSubmitLeaveOfficeReqeust : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid
                     accountid:(NSString *)accountid
                        reason:(NSString *)reason
                     approvaid:(NSString *)approvaid
                separationdate:(NSString *)separationdate;
@end

