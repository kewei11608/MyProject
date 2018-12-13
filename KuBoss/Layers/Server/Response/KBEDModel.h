//
//  KBEDModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"


@interface KBBottomEDTimeModel : NSObject
@property (nonatomic,assign) NSInteger date;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hours;
@property (nonatomic,assign) NSInteger minutes;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger seconds;
@property (nonatomic,assign) NSInteger time;
@property (nonatomic,assign) NSInteger timezoneOffset;
@property (nonatomic,assign) NSInteger year;

@end

@interface KBBottomEDModel : NSObject

@property (nonatomic,copy) NSString *realtyid;
@property (nonatomic,copy) NSString *customerid;
@property (nonatomic,copy) NSString *propertyname;
@property (nonatomic,copy) NSString *customername;
@property (nonatomic,copy) NSString *types;
@property (nonatomic,copy) NSString *operationtime;

- (NSString *)title;

- (NSArray *)array;

@end

@interface KBMidEDModel : NSObject

@property (nonatomic,strong)NSArray *EmployeeDynamicslist;
@property (nonatomic,copy) NSString *userid;

@end

@interface KBEDModel : KBBaseModel
@property (nonatomic,strong)KBMidEDModel *data;

@end
