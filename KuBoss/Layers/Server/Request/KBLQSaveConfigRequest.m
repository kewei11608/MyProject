//
//  KBLQSaveConfigRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQSaveConfigRequest.h"
@interface KBLQSaveConfigRequest ()
@property (nonatomic,strong) NSString *weeklyReminderTime;
@property (nonatomic,strong) NSString *monthRemindingTime;
@property (nonatomic,assign) NSInteger remindingz;
@property (nonatomic,assign) NSInteger remindingy;
@property (nonatomic,copy  ) NSString * listString;
@property (nonatomic,assign) NSInteger  noticetype;

@end
@implementation KBLQSaveConfigRequest

- (instancetype)initWithUserid:(NSString *)userid
            weeklyReminderTime:(NSString *)weeklyReminderTime
            monthRemindingTime:(NSString *)monthRemindingTime
                    listString:(NSString*)listString
                    noticetype:(NSInteger)noticetype
                    remindingz:(NSInteger)remindingz
                    remindingy:(NSInteger)remindingy
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.weeklyReminderTime = weeklyReminderTime;
    self.monthRemindingTime = monthRemindingTime;
    self.remindingy  = remindingy;
    self.remindingz = remindingz;
    self.listString = listString;
    self.noticetype = noticetype;
    return self;
}
    

- (NSString *)baseRequestUrl
{
    return @"/lqcc/saveLowQuantizationSetting";
}

- (id)baseRequestArgument
{
    if (self.monthRemindingTime) {
        if (self.listString) {
            return @{@"userid":self.uid,
                     @"reminding":@(self.remindingz),
                     @"noticetype":@(self.noticetype),
                     @"officeid":self.listString
                     };
        }
        return @{@"userid":self.uid,
                 @"monthRemindingTime":self.monthRemindingTime,
                 @"remindingz":@(self.remindingz),
                 @"noticetype":@(self.noticetype)
                 };
    }
    if (self.weeklyReminderTime) {
        if (self.listString) {
            return @{@"userid":self.uid,
//                     @"weeklyReminderTime":self.weeklyReminderTime,
                     @"reminding":@(self.remindingz),
                     @"noticetype":@(self.noticetype),
                     @"officeid":self.listString
                     };
        }
        return @{@"userid":self.uid,
                 @"weeklyReminderTime":self.weeklyReminderTime,
                 @"remindingz":@(self.remindingz),
                 @"noticetype":@(self.noticetype)
                 };
        
    }
    
    return  nil;
}

@end
