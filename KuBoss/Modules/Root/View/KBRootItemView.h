//
//  KBRootItemView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickTabBlock_t)(NSInteger tag);

@interface KBRootItemView : UIView
@property (nonatomic,copy)clickTabBlock_t clickTabBlock;

- (void)setNumber:(NSInteger) number;



@end
