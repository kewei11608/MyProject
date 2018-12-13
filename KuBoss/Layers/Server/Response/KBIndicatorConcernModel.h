//
//  KBIndicatorConcernModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"
@interface KBBottomIndicatorConcernModel : NSObject

@property (nonatomic,copy) NSString *targetid; // 指标id
@property (nonatomic,copy) NSString *targetname; // 指标名称
@property (nonatomic,copy) NSString *targetnameunit; // 指标数据单位
@property (nonatomic,copy) NSString *targetdata; // 指标对应数字
@property (nonatomic,copy) NSString *targettype; // 指标类型

@property (nonatomic,assign) BOOL   isFollowed; // 

@end

@interface KBMidIndicatorConcernModel : NSObject

@property (nonatomic,strong)NSArray *targetlist;
@property (nonatomic,copy)  NSString *userid;
@property (nonatomic,copy)  NSString *zhibiaolx;

@end

@interface KBIndicatorConcernModel : KBBaseModel

@property (nonatomic,strong)KBMidIndicatorConcernModel *data;

@end
