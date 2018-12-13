//
//  KBShopAgentModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBBottomShopAgentModel : NSObject
@property (nonatomic,copy) NSString *officeid; // 经纪人id
@property (nonatomic,copy) NSString *officename; // 经纪人名称
@property (nonatomic,copy) NSString *agentid; // 门店id
@property (nonatomic,copy) NSString *agentname; //门店名称
@property (nonatomic,copy) NSString *agentphone; //经纪人电话
@property (nonatomic,copy) NSString *akealooksdata; //经纪人头像
@property (nonatomic,copy) NSString *addavailabilitynumber; // 新增房源数
@property (nonatomic,copy) NSString *addtakealookinumber; //新增带看数
@property (nonatomic,copy) NSString *agencysidesnumber; //签约边数
@property (nonatomic,copy) NSString *addtouristnumber; //新增客源数
@property (nonatomic,copy) NSString *addrealservicenumber; //新增实勘数
@property (nonatomic,copy) NSString *agencyperformance; //总业绩
@property (nonatomic,copy) NSString *addaccurateguestnumber; //新增确客
@property (nonatomic,copy) NSString *addsubscribenumber; //新增认购
@property (nonatomic,copy) NSString *addreportnumber; //新增报备
@end

@interface KBMidShopAgentModel : NSObject
@property (nonatomic,strong) NSArray *zrzsj;
@end

@interface KBShopAgentModel : KBBaseModel
@property (nonatomic,strong) KBMidShopAgentModel *data;

@end
