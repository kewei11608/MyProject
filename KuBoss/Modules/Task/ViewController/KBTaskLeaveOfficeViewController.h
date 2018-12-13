//
//  KBTaskLeaveOfficeViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/5/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBTaskLeaveOfficeViewController : UIViewController

- (instancetype)initWithAccountid:(NSInteger)accountid agentName:(NSString *)agentName;
@property (nonatomic, copy) NSString *approvaid;

@end
