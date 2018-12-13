//
//  KBRequestManager.h
//  KuBoss
//
//  Created by lidan on 2018/11/14.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBRequestManager : KBBaseRequest
- (instancetype)initWithrequesturl:(NSString*)url AndDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
