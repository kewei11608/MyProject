//
//  KBTaskHouseRefuseViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submitBlock_t)(NSString *input);
@interface KBTaskHouseRefuseViewController : UIViewController
@property (nonatomic,copy)submitBlock_t submitBlock;
@end
