//
//  KBAccountFreezeListModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBAccountFreezeModel : NSObject
@property (nonatomic,strong) NSString * agenthead;
@property (nonatomic,strong) NSString * accountid;
@property (nonatomic,strong) NSString * approveType;
@property (nonatomic,strong) NSString * agentname;
@property (nonatomic,strong) NSString * frozentime;

//==
@property (nonatomic,strong) NSString * approvajlid;
@property (nonatomic,strong) NSString * approvaid;
@property (nonatomic,strong) NSString * areacode;
@property (nonatomic,strong) NSString * agentaccountid;
@property (nonatomic,strong) NSString * agentid;
@property (nonatomic,strong) NSString * functiontype;
@property (nonatomic,strong) NSString * approvalstatus;
@property (nonatomic,strong) NSString * approveagentid;
@property (nonatomic,strong) NSString * launchtime;
@property (nonatomic,strong) NSString * explains;
@property (nonatomic,strong) NSString * createtime;


@end

@interface KBAccountFreezeListData : NSObject
@property (nonatomic,assign) NSInteger freezeCount;
@property (nonatomic,assign) NSInteger unapprovednumber;
@property (nonatomic,strong) NSArray<KBAccountFreezeModel*> * freezeList;
@property (nonatomic,strong) NSArray<KBAccountFreezeModel*> * arrays;
@end

@interface KBAccountFreezeListModel : KBBaseModel
@property (nonatomic,strong) KBAccountFreezeListData *data;
@end
