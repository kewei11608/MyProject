//
//  LeaveOfficeView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submitBlock_t)(NSString *string);
typedef void (^dateBlock_t)(void);
@interface LeaveOfficeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *agentcodeLable;
@property (weak, nonatomic) IBOutlet UILabel *agentnameLable;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *inputTextLable;

@property (copy,nonatomic) submitBlock_t submitBlock;
@property (copy,nonatomic) dateBlock_t dateBlock;

@end
