//
//  KBLQUserConfigModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBLQConfigModel : NSObject
@property (nonatomic,copy) NSString *availabilitynumber; //房源达标数
@property (nonatomic,copy) NSString *realservicenumber; //实勘
@property (nonatomic,copy) NSString *takealookinumber; //带看
@property (nonatomic,copy) NSString *touristnumber; //客源达标数
@property (nonatomic,copy) NSString *lowquantificationtype; // 0 周 1 月


@end

@interface KBLQUserShopModel : NSObject
@property (nonatomic,copy) NSString *officename;
@property (nonatomic,copy) NSString *officeid;
@property (nonatomic,copy) NSString *reminding;// 1 提醒 0 未提醒




@end
@interface KBMidLQUserConfigModel : NSObject
@property (nonatomic,copy) NSString *monthremindingtime;
@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *weeklyremindertime;
@property (nonatomic,copy) NSString *updatetime;
@property (nonatomic,assign) NSInteger  id;
@property (nonatomic,assign) NSInteger  remindingz;
@property (nonatomic,assign) NSInteger  remindingy;
@property (nonatomic,strong) NSArray  *mdxx;
@property (nonatomic,strong) NSArray  *dlhbz;


@end
@interface KBLQUserConfigModel : KBBaseModel
@property (nonatomic,strong) KBMidLQUserConfigModel *data;
@end

