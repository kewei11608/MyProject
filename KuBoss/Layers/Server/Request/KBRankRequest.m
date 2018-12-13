//
//  KBRankRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankRequest.h"
@interface KBRankRequest ()

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger tradetype;
@property (nonatomic,assign) NSInteger size;
@property (nonatomic,copy)   NSString * month;

@end
@implementation KBRankRequest

- (instancetype)initWithUserid:(NSString *)userid
                     tradeType:(NSInteger)tradetype
                          page:(NSInteger)page
                          size:(NSInteger)size
                         month:(NSString *)month
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.tradetype = tradetype;
    self.page = page;
    self.size = size;
    self.month = month;
    
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/ylist/getall";
}


- (id)baseRequestArgument
{
    if (self.tradetype==-1) {
        return @{@"userid":self.uid,
                 @"page":@(self.page),
                 @"size":@(self.size),
                 @"datefw":self.month};
    }
    return @{@"userid":self.uid,
             @"page":@(self.page),
             @"size":@(self.size),
             @"tradetype":@(self.tradetype),
             @"datefw":self.month};
}

@end
