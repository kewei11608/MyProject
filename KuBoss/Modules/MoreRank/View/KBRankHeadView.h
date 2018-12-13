//
//  KBRankHeadView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^rankBlock_t)();

@interface KBRankHeadView : UIView
@property (nonatomic,strong)UILabel *leftLable;
@property (nonatomic,strong)UILabel *rightLable;

@property (nonatomic,strong) rankBlock_t rankBlock;

- (void)setTitle:(NSString *)title;

@end
