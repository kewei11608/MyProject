//
//  KBRoomDetailRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/28.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRoomDetailRequest.h"
@interface KBRoomDetailRequest ()
@property (nonatomic,assign) NSInteger realtyid;

@end
@implementation KBRoomDetailRequest
- (instancetype)initWithUserid:(NSString *)userid realtyid:(NSInteger)realtyid
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.realtyid = realtyid;
    return self;
}
- (NSString *)baseRequestUrl
{
    return @"/task/getRoomDetails";
}

- (id)baseRequestArgument
{
    
    return @{@"userid":self.uid,@"realtyid":@(self.realtyid)};
}
@end
