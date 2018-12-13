//
//  KBPermissionModel.h
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBBanerModel.h"


@interface KBPermission : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,assign) BOOL isGranted;
@end

@interface KBPermissionData : NSObject
@property (nonatomic,strong) NSArray *auth;
@end


@interface KBPermissionModel : KBBaseModel
@property (nonatomic,strong) KBPermissionData *data;
@end
