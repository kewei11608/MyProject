//
//  KBTaskHouseAgreeViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^agreeControllerBlock_t)(NSString *str);

@interface KBTaskHouseAgreeViewController : UIViewController
@property (nonatomic,copy) agreeControllerBlock_t agreeControllerBlock;
- (instancetype)initRealtyid:(NSInteger)realtyid approvaid:(NSString *)approvaid;



@end
