//
//  KBShopRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShopRequest.h"
@interface KBShopRequest ()
@property (nonatomic,copy) NSString * officeid;
@property (nonatomic,assign) NSInteger timetype;
@property (nonatomic,assign) NSInteger daterange;
@property (nonatomic,assign) NSInteger housingtype;

@end
@implementation KBShopRequest
- (instancetype)initWithUserid:(NSString *)userid
                      officeid:(NSString *) officeid
                      timetype:(NSInteger) timetype
                     daterange:(NSInteger)daterange
                   housingtype:(NSInteger)housingtype

{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.officeid = officeid;
    self.timetype = timetype;
    self.daterange = daterange;
    self.housingtype = housingtype;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/bmac/ymszxselect";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid,@"officeid":self.officeid,@"timetype":@(self.timetype),@"daterange":@(self.daterange),@"housingtype":@(self.housingtype)};
}
@end
