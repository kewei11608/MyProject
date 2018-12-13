//
//  KBLQItemModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBLQItemSub : NSObject
@property (nonatomic, assign) NSInteger zhoushu;

@property (nonatomic, copy) NSString *agenthead;

@property (nonatomic, copy) NSString *agentid;
@property (nonatomic, assign) NSInteger recordstatus;
@property (nonatomic, assign) NSInteger availabilityrnumber;
@property (nonatomic, assign) NSInteger takealookirnumber;
@property (nonatomic, assign) NSInteger takealookinumber;
@property (nonatomic, assign) NSInteger realservicernumber;
@property (nonatomic, assign) NSInteger touristrnumber;
@property (nonatomic, assign) NSInteger availabilitynumber;
@property (nonatomic, assign) NSInteger realservicenumber;
@property (nonatomic, assign) NSInteger touristnumber;

@property (nonatomic, copy) NSString *lqtagging;
@property (nonatomic, copy) NSString *officename;
@property (nonatomic, copy) NSString *officeid;
@property (nonatomic, copy) NSString *guidance;

@property (nonatomic, copy) NSString *agentname;


@property (nonatomic, copy) NSString *agentphone;

@end

@interface KBLQItemData : NSObject
@property (nonatomic,assign) NSInteger bjdlhzsl;
@property (nonatomic,strong) NSArray<KBLQItemSub *>* grdlhsj;
@property (nonatomic,assign) NSInteger sfjrxq;

@end

@interface KBLQItemModel : KBBaseModel
@property (nonatomic,strong)KBLQItemData *data;
@end
