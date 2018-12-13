//
//  KBLQModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

@interface KBMidLQModel : KBBaseModel
@property (nonatomic,copy) NSString *zongshu; // 经纪人半年的低量化次数
@property (nonatomic,copy) NSString *zhoushu; // 经纪人半年以周为标准的地量化次数
@property (nonatomic,copy) NSString *yueshu; // 经纪人半年以月为标准的低量化次数
@property (nonatomic,copy) NSString *sflx; //是否连续每月（0-没有连续、其它数字为连续几月）

@end

@interface KBLQModel : KBBaseModel
@property (nonatomic,strong) KBMidLQModel *data;

@end
