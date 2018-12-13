//
//  KBLQSaveConfigRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBLQSaveConfigRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
            weeklyReminderTime:(NSString *)weeklyReminderTime
            monthRemindingTime:(NSString *)monthRemindingTime
                    listString:(NSString*)listString
                    noticetype:(NSInteger)noticetype
                    remindingz:(NSInteger)remindingz
                    remindingy:(NSInteger)remindingy;

@end
