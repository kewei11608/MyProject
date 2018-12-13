//
//  KBRouter.h
//  KBTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 KBun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, KBRouteType) {
    KBRouteTypeNone = 0,
    KBRouteTypeViewController = 1,
    KBRouteTypeBlock = 2
};

typedef id (^KBRouterBlock)(NSDictionary *params);

@interface KBRouter : NSObject

+ (instancetype)sharedInstance;


- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;

- (UIViewController *)matchController:(NSString *)route;

- (void)map:(NSString *)route toBlock:(KBRouterBlock)block;
- (KBRouterBlock)matchBlock:(NSString *)route;
- (id)callBlock:(NSString *)route;

- (KBRouteType)canRoute:(NSString *)route;

- (void)pushByRoute:(NSString *)route animated:(BOOL)animated;

- (void)presentByRoute:(NSString *)route  animated:(BOOL)animated;



@end
