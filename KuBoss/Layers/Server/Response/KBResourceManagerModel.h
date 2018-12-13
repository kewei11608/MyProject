//
//  KBResourceManagerModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBGgmdimModel : NSObject
@property (nonatomic,copy) NSString *officeid;
@property (nonatomic,copy) NSString *officename;
@property (nonatomic,assign) BOOL  isSame;
@end


@interface KBSymdxxzhModel : NSObject

@property (nonatomic,copy) NSString *tradetype;
@property (nonatomic,copy) NSString *realtynumber;
@property (nonatomic,copy) NSString *realtynumberavg;
@property (nonatomic,copy) NSString *bambooflagnumber;
@property (nonatomic,copy) NSString *customernumber;
@property (nonatomic,copy) NSString *customernumberavg;
@property (nonatomic,copy) NSString *showpercentage;
@property (nonatomic,copy) NSString *reportnumber;
@property (nonatomic,copy) NSString *reportnumberavg;
@property (nonatomic,copy) NSString *leasehold;
@property (nonatomic,copy) NSString *rentalhousing;

@end

@interface KBMidResourceManagerModel : NSObject
@property (nonatomic,strong) NSArray *mdxxzh;
@property (nonatomic,strong) NSArray *ggmdim;
@property (nonatomic,copy) NSString *gxrq;

@end

@interface KBResourceManagerModel : KBBaseModel
@property (nonatomic,strong)KBMidResourceManagerModel *data;
@end
