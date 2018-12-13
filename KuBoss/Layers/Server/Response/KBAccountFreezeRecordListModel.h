//
//  AccountFreezeRecordListModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBAccountFreezeRecordItem : NSObject
@property (nonatomic, copy) NSString *agenthead;
@property (nonatomic, copy) NSString *launchtime;
@property (nonatomic, copy) NSString *approveType;
@property (nonatomic, copy) NSString *approvalstatus;
@property (nonatomic, copy) NSString *agentname;
@property (nonatomic, copy) NSString *frozentime;
@property (nonatomic, copy) NSString *accountid;
@property (nonatomic, copy) NSString *approvaid;
@property (nonatomic, copy) NSString *audittime;
                                      




@end

@interface KBAccountFreezeRecordListData : NSObject
@property (nonatomic,strong) NSArray <KBAccountFreezeRecordItem *>  *oldData;
@property (nonatomic,strong) NSArray <KBAccountFreezeRecordItem *>  *monthData;
@property (nonatomic,strong) NSArray <KBAccountFreezeRecordItem *>  *earlier;
@property (nonatomic,strong) NSArray <KBAccountFreezeRecordItem *>  *nearlyamonth;
@property (nonatomic,assign) NSInteger monthDataSize;
@property (nonatomic,assign) NSInteger oldDataSize;
@property (nonatomic,assign) NSInteger nearlyamonthnumber;
@property (nonatomic,assign) NSInteger earliernumber;


@end

@interface KBAccountFreezeRecordListModel : KBBaseModel

@property (nonatomic,strong) KBAccountFreezeRecordListData  *data;

@end
