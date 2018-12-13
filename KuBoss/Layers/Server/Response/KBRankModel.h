//
//  KBRankModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"


@interface KBMidRankModel : NSObject

@property (nonatomic,copy) NSString *areacode; //区域id（关联区域信息表）
@property (nonatomic,copy) NSString *dataloggingyid; // 门店id（关联门店信息表）
@property (nonatomic,copy) NSString *oaddaccurateguestynumber;
@property (nonatomic,copy) NSString *oaddavailabilityynumber; //新增房源数
@property (nonatomic,copy) NSString *oaddrealserviceynumber; //新增实勘数
@property (nonatomic,copy) NSString *oaddreportynumber;  //新增报备数
@property (nonatomic,copy) NSString *oaddsubscribeynumber; //新增认购数
@property (nonatomic,copy) NSString *oaddtakealookiynumber; // 新增带看数
@property (nonatomic,copy) NSString *oaddtime;  //添加时间
@property (nonatomic,copy) NSString *oaddtouristynumber; //新增客源数
@property (nonatomic,copy) NSString *oagencyperformancey; //总业绩
@property (nonatomic,copy) NSString *oagencysidesynumber; //总签约边数
@property (nonatomic,copy) NSString *officeid; //门店id
@property (nonatomic,copy) NSString *officename; //门店名称
@property (nonatomic,copy) NSString *omonths; //月份
@property (nonatomic,copy) NSString *tradetype; //住房类型（0-二手房、1-租房（包括租赁和租售）2-新房）
@property (nonatomic,assign) NSInteger index;


@end

@interface KBRankModel : KBBaseModel
@property (nonatomic,strong) NSArray *data;

@end
