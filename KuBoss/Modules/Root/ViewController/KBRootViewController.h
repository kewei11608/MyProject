//
//  KBRootViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBRootViewController : UIViewController
@property (nonatomic,strong) KBPermissionModel *permissionModel;

+ (instancetype)sharedInstaced;

- (BOOL)isHavaPermission:(NSString *)permissionCode;

@end
