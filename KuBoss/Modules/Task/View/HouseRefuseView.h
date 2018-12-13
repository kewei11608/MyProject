//
//  HouseRefuseView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^submitBlock_t)(NSString *input);

@interface HouseRefuseView : UIView
@property (copy, nonatomic) submitBlock_t submitBlock;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *inputTextLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@end
