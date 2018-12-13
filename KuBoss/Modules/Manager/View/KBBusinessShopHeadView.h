//
//  KBBusinessShopHeadView.h
//  KuBoss
//
//  Created by sunruixue on 2018/4/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBusinessShopHeadView : UIView
@property (nonatomic,assign) BOOL isNew;
- (void)setModel:(KBShopTotalModel *)model;
- (void)setShopName:(NSString *)shopName;

@end
