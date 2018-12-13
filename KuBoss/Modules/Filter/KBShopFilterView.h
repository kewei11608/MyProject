//
//  KBShopFilterView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^filterShopBlock_t)(NSString *shopId ,NSString *shopName);

@interface KBShopFilterView : UIView

@property (nonatomic,copy) filterShopBlock_t filterShopBlock;

- (void)setShopList:(NSArray *)array;

@end
