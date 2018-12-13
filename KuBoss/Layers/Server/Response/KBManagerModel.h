//
//  KBManagerModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/18.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBShopListModel : NSObject
@property (nonatomic,copy)   NSString  *officeid;
@property (nonatomic,copy)   NSString  *officename;
@property (nonatomic,assign)   BOOL  isSame;

@end

@interface KBManageListModel : NSObject
@property (nonatomic,assign) NSInteger  realtynumber; // 库存房源数
@property (nonatomic,assign) NSInteger  realtynumberavg; //库存房源人均数
@property (nonatomic,assign) NSInteger  bambooflagnumber; //笋盘数
@property (nonatomic,assign) NSInteger  leasehold; //笋盘数
@property (nonatomic,assign) NSInteger  rentalhousing; //租赁房源数
@property (nonatomic,assign) NSInteger  customernumber; //库存客源数
@property (nonatomic,assign) NSInteger   customernumberavg; //存客源人均数
@property (nonatomic,assign) CGFloat     showpercentage; //近30日内有带看的百分数
@property (nonatomic,assign) NSInteger   reportnumberavg; //报备人均数
@property (nonatomic,assign) NSInteger   tradetype; // 住房类型1-二手房、2-租房（包括租赁和租售）、3-新房）


@end

@interface KBMidManagerModel : NSObject
@property (nonatomic,strong)  NSArray <KBManageListModel *>*symdxxzh;
@property (nonatomic,strong)  NSArray <KBShopListModel *> *ggmdim;
@property (nonatomic,copy) NSString  *gxrq;

@end

@interface KBManagerModel : KBBaseModel

@property (nonatomic,strong) KBMidManagerModel *data;

@end
