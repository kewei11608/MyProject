//
//  KBSubmitLeaveOfficeReqeust.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSubmitLeaveOfficeReqeust.h"
@interface KBSubmitLeaveOfficeReqeust ()
@property (nonatomic,assign) NSString * accountid;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,copy) NSString *approvaid;
@property (nonatomic,copy) NSString *separationdate;
@end
@implementation KBSubmitLeaveOfficeReqeust
- (instancetype)initWithUserid:(NSString *)userid
                     accountid:(NSString *)accountid
                        reason:(NSString *)reason
                     approvaid:(NSString *)approvaid
                separationdate:(NSString *)separationdate
{
    self = [super initWithUserid:userid];
    if (!self) return  nil;
    self.accountid = accountid;
    self.reason =reason;
    self.approvaid = approvaid;
    self.separationdate = separationdate;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/submitLeaveOffice";
}

- (id)baseRequestArgument
{
    
    return @{@"accountid":self.accountid,
             @"userid":self.uid,
             @"leaveReason":self.reason,
             @"separationdate":self.separationdate,
             @"approvaid":self.approvaid};
}
@end
