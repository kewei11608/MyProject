//
//  KBModulesRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/2.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModulesRequest.h"
@interface KBModulesRequest ()
@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,assign) NSInteger  pageSize;
@end
@implementation KBModulesRequest
- (instancetype)initWithUserid:(NSString *)userid
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.pageIndex = pageIndex;
    self.pageSize  = pageSize;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/bilist/getbi";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,
             @"page":@(self.pageIndex),
             @"size":@(self.pageSize),
//             @"areaCode":[KBUserInfoModel areaCode]
             };
}
@end
