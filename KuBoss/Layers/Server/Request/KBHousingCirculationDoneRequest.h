//
//  KBHousingCirculationDone.h
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBHousingCirculationDoneRequest : KBBaseRequest
- (instancetype)initWithUserid:(NSString *)userid approvaid:(NSString *)approvaid;

@end
