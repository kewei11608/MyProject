//
//  KBAccountFreezeDetailModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBAccountFreezeDetailData : NSObject
@property (nonatomic, copy) NSString *agentphone;

@property (nonatomic, copy) NSString *agenthead;

@property (nonatomic, copy) NSString *englishname;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *approvalstatus;

@property (nonatomic, copy) NSString *deptname;

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, copy) NSString *agentcode;

@property (nonatomic, copy) NSString *agentname;

@property (nonatomic, copy) NSString *approvaid;

@property (nonatomic, copy) NSString *accountid;

@property (nonatomic, copy) NSString *cccncode;

@property (nonatomic, copy) NSString *launchtime;

@property (nonatomic, copy) NSString *agentstatus;

@property (nonatomic, copy) NSString *agenttype;

@property (nonatomic, copy) NSString *entrytime;

@property (nonatomic, copy) NSString *postname;

@property (nonatomic, copy) NSString *userhead;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *audittime;

@property (nonatomic, copy) NSString *frozentime;

@property (nonatomic, copy) NSString *approveType;







@end
@interface KBAccountFreezeDetailModel : KBBaseModel
@property  (nonatomic,strong) KBAccountFreezeDetailData *data;
@end
