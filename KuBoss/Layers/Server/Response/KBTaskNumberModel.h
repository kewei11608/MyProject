//
//  KBTaskNumberModel.h
//  KuBoss
//
//  Created by yuyang on 2018/6/16.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"
@interface KBTaskNumber : NSObject
@property (nonatomic,copy) NSString *approvalstatus;
@property (nonatomic,copy) NSString *freezeCount;
@property (nonatomic,copy) NSString *hcnumber;
@end
@interface KBTaskNumberModel : KBBaseModel
@property (nonatomic,strong)KBTaskNumber *data;
@end
