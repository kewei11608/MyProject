//
//  KBRequestManager.m
//  KuBoss
//
//  Created by lidan on 2018/11/14.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "KBRequestManager.h"
@interface KBRequestManager ()
@property (nonatomic,strong) NSDictionary * dic;
@property (nonatomic,copy) NSString     *   requesturl;;
@end
@implementation KBRequestManager
- (instancetype)initWithrequesturl:(NSString *)url
                           AndDict:(NSDictionary *)dict
{
    self = [super initWithUserid:nil];
    if (!self) return nil;
    self.dic = dict;
    self.requesturl  = url;
    return self;
}

- (NSString *)baseRequestUrl
{
    return _requesturl;
}

- (id)baseRequestArgument
{
    
    return _dic;
}
//- (NSString *)requestUrl {
//    return @"http://pc123.tg5677.com/api/";
//}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodPOST;
}
//- (NSString *)requestUrl {
//    return [NSString stringWithFormat:@"%@%@",httpFilePath,[self baseRequestUrl]];
//}

@end
