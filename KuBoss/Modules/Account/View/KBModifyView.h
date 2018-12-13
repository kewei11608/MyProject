//
//  KBModifyView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ModifyViewActionDelegate<NSObject>
@optional
- (void)callIphoneState:(KBModifyIphoneState )iphoneState passwordInput:(NSString *)password;

- (void)callIphoneState:(KBModifyIphoneState )iphoneState iphoneInput:(NSString *)iphone code:(NSString *)code;

- (void)callPasswordState:(KBModifyPasswordState )passwordState oldPassword:(NSString *)oldPassword password:(NSString *)password;

- (void)callAlterMessage:(NSString *)message;

- (void)callSmsCodeIphoneInput:(NSString *)iphone;

@end

@interface KBModifyView : UIView

@property (nonatomic,weak) id <ModifyViewActionDelegate>delegate;

@property (nonatomic,assign)KBModifyViewType modifyViewType;

@property (nonatomic,assign) KBModifyIphoneState modifyIphoneState; //手机-状态
@property (nonatomic,assign) KBModifyPasswordState modifyPasswordState;//密码-状态

- (void)setIphoneState:(KBModifyIphoneState )iphoneState;

- (void)setPasswordState:(KBModifyPasswordState )passwordState;


@end
