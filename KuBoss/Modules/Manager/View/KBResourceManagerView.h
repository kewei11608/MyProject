//
//  KBResourceManagerView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^filterVShopBlock_t)(NSString *shopId);

@interface KBResourceManagerView : UIView

@property (nonatomic,copy) filterVShopBlock_t filterShopBlock;

- (void)setModel:(KBResourceManagerModel *)model;

@end
