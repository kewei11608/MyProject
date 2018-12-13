//
//  KBHandleLeaveOfficeModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBHandleLeaveOfficeData : NSObject
@property (nonatomic,strong)NSString *approvaid;
@property (nonatomic,strong)NSString *accountid;
@property (nonatomic,strong)NSString *agentname;


@end

@interface KBHandleLeaveOfficeModel : KBBaseModel
@property (nonatomic,strong) KBHandleLeaveOfficeData *data;
@end
