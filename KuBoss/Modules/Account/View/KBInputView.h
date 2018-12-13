//
//  KBInputView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBInputView : UIView

@property (nonatomic,assign) BOOL secureTextEntry;

- (instancetype)initWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon   text:(NSString *)text;

- (NSString *)inputText;

- (void)setBgRadius:(NSInteger) radius ;

- (void)setText:(NSString *)text;

@end
