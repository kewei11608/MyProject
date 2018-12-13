//
//  KBWarReportModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBMidWarReportModel : NSObject
@property (nonatomic,copy) NSString *agentname; //经纪人姓名
@property (nonatomic,copy) NSString *officename; //门店名称
@property (nonatomic,copy) NSString *regionaliname; //区域名称
@property (nonatomic,copy) NSString *signingjlid; // 数据记录id
@property (nonatomic,copy) NSString *signingtime; //签约时间
@property (nonatomic,copy) NSString *housename; //
@property (nonatomic,copy) NSString *area; //
@property (nonatomic,copy) NSString *message; //

@end
@interface KBWarReportModel : KBBaseModel
@property (nonatomic,strong) NSArray *data;
@end
