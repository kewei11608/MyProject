//
//  WHBaseRequest.h
//  Pods
//
//  Created by yuyang on 2018/5/2.
//

#import "YTKRequest.h"

@interface KBBaseRequest : YTKRequest
@property (nonatomic,copy) NSString *uid;
- (instancetype)initWithUserid:(NSString *)userid;

- (NSString *)baseRequestUrl;

- (YTKRequestMethod)baseRequestMethod;

- (id)baseRequestArgument;

@end
