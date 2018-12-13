//
//  KBLQItemView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^reminderActionBlcok_t)();
@interface ItemView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *inputTextLable;
@property (weak, nonatomic) IBOutlet UILabel *tip;

@property (copy, nonatomic) reminderActionBlcok_t reminderActionBlcok;
@end
