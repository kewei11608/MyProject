//
//  KBDeatilMessageViewController.h
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBDetailMessageViewController : UIViewController

- (instancetype)initMessageId:(NSString *)messageId type:(NSString *)type;

@property (nonatomic, copy) NSString *messageTitle;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, assign) NSInteger sharetf;

@end
