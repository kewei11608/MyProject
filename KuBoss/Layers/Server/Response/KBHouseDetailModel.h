//
//  KBHouseDetailModel.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBHouseDetailItem : KBBaseModel

@property (nonatomic,strong) NSString *approvajlid;
@property (nonatomic,strong) NSString *approvaid;
@property (nonatomic,strong) NSString *areacode;
@property (nonatomic,strong) NSString *agentaccountid;
@property (nonatomic,strong) NSString *agentid;
@property (nonatomic,strong) NSString *functiontype;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *approveagentid;
@property (nonatomic,strong) NSString *launchtime;
@property (nonatomic,strong) NSString *explains;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *agenthead;//经纪人头像
@property (nonatomic,strong) NSString *agentname;//经纪人姓名
@property (nonatomic,strong) NSString *agentphone;//经纪人电话
@property (nonatomic,strong) NSString *officename;//
@property (nonatomic,strong) NSString *realtyid;
@property (nonatomic,strong) NSString *realtynum;
@property (nonatomic,strong) NSString *communityname;//物业名称
@property (nonatomic,strong) NSString *strrealtytype;//物业类型
@property (nonatomic,copy)   NSString *username;// 审核人名称
@property (nonatomic,copy)   NSString *userhead;// 审核人头像
@property (nonatomic, copy) NSString *approvalstatus;

@property (nonatomic, copy) NSString *audittime; // 审核时间


@end

@interface KBHouseDetailModel : KBBaseModel

@property (nonatomic,strong) KBHouseDetailItem *data;

@end
