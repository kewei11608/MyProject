//
//  KSYTabbarModel.h
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYTabbarModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *image_hl;
@property (nonatomic,copy)NSString *className;

@end

@interface  KSYTabbarSourceModel : NSObject
@property (nonatomic, strong) NSArray<KSYTabbarModel*>* items;

@end
