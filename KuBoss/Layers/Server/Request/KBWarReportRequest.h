//
//  KBWarReportRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

//获取战报数
@interface KBWarReportRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid page:(NSInteger )page size:(NSInteger )size;
@end
