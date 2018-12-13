//
//  KBShopModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"
@class KBMidShopModel,KBShopTotalModel,KBAgenListModel;

@interface KBShopModel : KBBaseModel
@property (nonatomic, strong) KBMidShopModel *data;
@end

@interface KBMidShopModel : NSObject

@property (nonatomic, strong) NSArray<KBShopTotalModel *> *zrzsj;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, strong) NSArray<KBAgenListModel *> *ggmdlist;
@property (nonatomic, strong) NSArray<KBGgmdimModel *> *ggmdim;
@property (nonatomic, copy) NSString *gxsj;


@end


@interface KBShopTotalModel : NSObject

@property (nonatomic, assign) CGFloat agencyperformance;

@property (nonatomic, assign) CGFloat agencysidesnumber;

@property (nonatomic, assign) NSInteger addavailabilitynumber; //新增房源
@property (nonatomic, assign) CGFloat   addavailabilitynumberavg;

@property (nonatomic, assign) NSInteger addtakealookinumber; //新增带看数
@property (nonatomic, assign) CGFloat   addtakealookinumberavg;

@property (nonatomic, assign) NSInteger addtouristnumber; //新增客源数
@property (nonatomic, assign) CGFloat   addtouristnumberavg;

@property (nonatomic, assign) NSInteger addrealservicenumber; //新增实勘数
@property (nonatomic, assign) CGFloat   addrealservicenumberavg;

@property (nonatomic, assign) NSInteger addaccurateguestnumber; //新增确客
@property (nonatomic, assign) CGFloat   addaccurateguestnumberavg;

@property (nonatomic, assign) NSInteger addsubscribenumber; //新增认购
@property (nonatomic, assign) CGFloat   addsubscribenumberavg;

@property (nonatomic, assign) NSInteger addreportnumber; //新增报备
@property (nonatomic, assign) CGFloat addreportnumberavg;






@end

@interface KBAgenListModel : NSObject

@property (nonatomic,copy) NSString *agentid; // 经纪人id
@property (nonatomic,copy) NSString *agentname; //经纪人名称
@property (nonatomic,copy) NSString *agentphone; //经纪人电话
@property (nonatomic,copy) NSString *akealooksdata; //经纪人头像
@property (nonatomic,copy) NSString *addavailabilitynumber; // 新增房源数
@property (nonatomic,copy) NSString *addtakealookinumber; //新增带看数
@property (nonatomic,copy) NSString *agencysidesnumber; //签约边数
@property (nonatomic,copy) NSString *addtouristnumber; //新增客源数
@property (nonatomic,copy) NSString *addrealservicenumber; //新增实勘数
@property (nonatomic,assign) float agencyperformance; //总业绩
@property (nonatomic,copy) NSString *addaccurateguestnumber; //新增确客
@property (nonatomic,copy) NSString *addsubscribenumber; //新增认购
@property (nonatomic,copy) NSString *addreportnumber; //新增报备

@end
