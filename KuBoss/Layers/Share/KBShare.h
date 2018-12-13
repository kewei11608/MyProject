//
//  KBShare.h
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <WechatOpenSDK/WXApiObject.h>
@interface KBShare : NSObject
+ (void)shareScene:(NSInteger) scene title:(NSString *)title  url:(NSString *)url content:(NSString *)content imgurl:(NSString *)imgurl;
@end
