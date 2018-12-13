//
//  KBLQItemViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBLQItemViewController : UIViewController

@property (nonatomic, copy) void(^block)(BOOL isMonth);

- (instancetype)initBool:(BOOL) isMonth agentId:(NSInteger) agentid lqid:(NSInteger)lqid;

- (void)setModel:(KBLQDetailModel * )model;

@end
