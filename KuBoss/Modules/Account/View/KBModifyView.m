//
//  KBModifyView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModifyView.h"
#import "KBProcessView.h"
#import "KBInputView.h"
#import "KBGlobalControllerCenter.h"

#define kProcessViewHeight  115

#define kInputFullString @"输入内容不能为空"
#define kInputIphoneString @"输入格式不正确"

@interface KBModifyView ()
@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *messageBtn;
@property (nonatomic,strong) UILabel  *tipLable;
@property (nonatomic,strong) UIImageView  *doneImageView;  //完成
@property (nonatomic,strong) UITextView   *doneIphoneLable;


@property (nonatomic,strong) KBProcessView *processView;
// 修改该手机
@property (nonatomic,strong) KBInputView *mLoginPasswordInputView;//登录密码
@property (nonatomic,strong) KBInputView *mLoginNewIphoneInputView;//登录新手机号

@property (nonatomic,strong) KBInputView *oPasswordInputView;//输入旧密码
@property (nonatomic,strong) KBInputView *nPasswordInputView;//输入新密码


@property (nonatomic,strong) KBInputView *mMessageInputView;//短信验证码

@property (nonatomic,copy) NSString * phone;

@end

@implementation KBModifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}


- (void)setModifyIphoneState:(KBModifyIphoneState)modifyIphoneState
{
    _modifyIphoneState = modifyIphoneState;
    switch (modifyIphoneState) {
        case KBModifyIphoneStateLoginPassword:
        {
            self.mLoginPasswordInputView.hidden = NO;
            self.mLoginNewIphoneInputView.hidden = YES;
            self.mMessageInputView.hidden = YES;
            self.messageBtn.hidden = YES;
            self.tipLable.hidden = YES;
            self.doneImageView.hidden = YES;
            self.doneIphoneLable.hidden = YES;
        }
            break;
        case KBModifyIphoneStateNewNumber:
        {
            self.mLoginPasswordInputView.hidden = YES;
            self.mLoginNewIphoneInputView.hidden = NO;
            self.mMessageInputView.hidden = NO;
            self.messageBtn.hidden = NO;
            self.tipLable.hidden = NO;
            self.doneImageView.hidden = YES;
            self.doneIphoneLable.hidden = YES;
        }
            
            break;
        case KBModifyIphoneStateSuccess:
        {
            self.mLoginPasswordInputView.hidden = YES;
            self.mLoginNewIphoneInputView.hidden = YES;
            self.mMessageInputView.hidden = YES;
            self.messageBtn.hidden = YES;
            self.tipLable.hidden = YES;
            self.doneImageView.hidden = NO;
            self.doneIphoneLable.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}


- (void)setModifyPasswordState:(KBModifyPasswordState)modifyPasswordState
{
    _modifyPasswordState = modifyPasswordState;
    switch (modifyPasswordState) {
        case KBModifyPasswordStateStart:
        {
            self.doneImageView.hidden = YES;
            self.doneIphoneLable.hidden = YES;
            self.oPasswordInputView.hidden = NO;
            self.nPasswordInputView.hidden = NO;
            self.tipLable.hidden = NO;
        }
            break;
        case KBModifyPasswordStateEnd:
        {
            self.doneImageView.hidden = NO;
            self.doneIphoneLable.hidden = NO;
            self.oPasswordInputView.hidden = YES;
            self.nPasswordInputView.hidden = YES;
            self.tipLable.hidden  = YES;
        }
            break;
            
        default:
            break;
    }
    
}


// iphone
- (void)setupLoginInputView
{
    self.mLoginPasswordInputView = [[KBInputView alloc]initWithFrame:CGRectMake(40, kProcessViewHeight + 55, self.ct_width-80, 40) leftIcon:@"loginlock" rightIcon:@"closeair"  text:@"请输入您的登录密码"];
    [self.mLoginPasswordInputView setBgRadius:4];
    [self addSubview:self.mLoginPasswordInputView];
    
    self.mLoginNewIphoneInputView = [[KBInputView alloc]initWithFrame:CGRectMake(40, kProcessViewHeight + 55, self.ct_width-80, 40) leftIcon:@"login_iphone" rightIcon:nil  text:@"请输入新的手机号码"];
    [self.mLoginNewIphoneInputView setBgRadius:4];
    [self addSubview:self.mLoginNewIphoneInputView];
    
    self.mMessageInputView = [[KBInputView alloc]initWithFrame:CGRectMake(40, self.mLoginPasswordInputView.ct_bottom+20, (self.ct_width-80)*0.53, 40) leftIcon:nil rightIcon:nil  text:@"请输入短信验证码"];
    [self.mMessageInputView setBgRadius:4];
    [self addSubview:self.mMessageInputView];
    [self addSubview:self.messageBtn];
    [self addSubview:self.tipLable];
    [self addSubview:self.doneImageView];
    [self addSubview:self.doneIphoneLable];
    
}

// password
- (void)setupPasswordInputView
{
    self.oPasswordInputView = [[KBInputView alloc]initWithFrame:CGRectMake(40, kProcessViewHeight + 55, self.ct_width-80, 40) leftIcon:@"loginlock" rightIcon:nil text:@"请输入您的旧密码"];
    [self.oPasswordInputView setBgRadius:4];
    [self addSubview:self.oPasswordInputView];
    
    self.nPasswordInputView = [[KBInputView alloc]initWithFrame:CGRectMake(40, self.oPasswordInputView.ct_bottom + 20, self.ct_width-80, 40) leftIcon:@"login_iphone" rightIcon:@"closeair"  text:@"请输入您的新密码"];
    [self.nPasswordInputView setBgRadius:4];
    [self addSubview:self.nPasswordInputView];

    [self addSubview:self.tipLable];
    self.tipLable.ct_top = self.nPasswordInputView.ct_bottom  + 10;
    self.tipLable.text = @"TIPS:密码由6-10位数字/英文组成";
    [self addSubview:self.doneImageView];
    [self addSubview:self.doneIphoneLable];
    
}

- (void)nextActon
{
    
    if (self.modifyViewType == KBModifyViewTypeIphone)
    {
        if (self.modifyIphoneState == KBModifyIphoneStateLoginPassword) {
            
            if ([self.mLoginPasswordInputView inputText] == 0) {
                [self alterMessage:kInputFullString];
                return;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(callIphoneState:passwordInput:)]) {
                [self.delegate callIphoneState:KBModifyIphoneStateLoginPassword passwordInput:[self.mLoginPasswordInputView inputText]];
            }
        }
        else if (self.modifyIphoneState == KBModifyIphoneStateNewNumber) {
            
            if ([self.mLoginNewIphoneInputView inputText].length == 0) {
                [self alterMessage:kInputFullString];
                return;
            }
            if ([self.mLoginNewIphoneInputView inputText].length != 11) {
                 [self alterMessage:kInputIphoneString];
                return;
            }
            if ([self.mMessageInputView inputText].length == 0) {
                [self alterMessage:kInputFullString];
                return;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(callIphoneState:iphoneInput:code:)]) {
                [self.delegate callIphoneState:KBModifyIphoneStateNewNumber iphoneInput:[self.mLoginNewIphoneInputView inputText] code:[self.mMessageInputView inputText]];
            }
            
        }
        else if (self.modifyIphoneState == KBModifyIphoneStateSuccess) {
            
            [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeSetting];
        }
    }
    else if (self.modifyViewType == KBModifyViewTypePassword)
    {
        if (self.modifyPasswordState == KBModifyPasswordStateStart) {
            if ([self.oPasswordInputView inputText].length == 0 || [self.nPasswordInputView inputText].length == 0) {
                [self alterMessage:kInputFullString];
                return;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(callPasswordState:oldPassword:password:)]) {
                [self.delegate callPasswordState:KBModifyPasswordStateStart oldPassword:[self.oPasswordInputView inputText] password:[self.nPasswordInputView inputText]];
            }
            
        }
        else if (self.modifyPasswordState == KBModifyPasswordStateEnd)
        {
              [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeSetting];
        }
    }
    
}

- (void)alterMessage:(NSString *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(callAlterMessage:)]) {
        [self.delegate callAlterMessage:message];
    }
}

- (void)setIphoneState:(KBModifyIphoneState )iphoneState{
    
    if (iphoneState == KBModifyIphoneStateLoginPassword) {
        self.modifyIphoneState = KBModifyIphoneStateNewNumber;
        [self.processView setModifyIphoneState:KBModifyIphoneStateNewNumber];
        [self.bottomBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    else if (iphoneState == KBModifyIphoneStateNewNumber) {
        self.modifyIphoneState = KBModifyIphoneStateSuccess;
        self.phone = [self.mLoginNewIphoneInputView inputText];
        [self.processView setModifyIphoneState:KBModifyIphoneStateSuccess];
        self.bottomBtn.ct_top =  self.doneIphoneLable.ct_bottom + 22.5;
        [self.bottomBtn setTitle:@"返回我的个人中心" forState:UIControlStateNormal];
        
        self.doneIphoneLable.text = [NSString stringWithFormat:@"当前手机号：%@\n\n您的手机号码已经修改成功啦，请您牢记并妥善保管您的账号信息哦！", [self.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.phone forKey:@"Phone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setPasswordState:(KBModifyPasswordState )passwordState{
    if (passwordState == KBModifyPasswordStateStart) {
        self.modifyPasswordState = KBModifyPasswordStateEnd;
        self.bottomBtn.ct_top =  self.doneIphoneLable.ct_bottom + 22.5;
        [self.bottomBtn setTitle:@"返回我的个人中心" forState:UIControlStateNormal];
        self.doneIphoneLable.text = @"您的密码已经修改成功啦，请您牢记并妥善保管您的账号信息哦！";
         [self.processView setModifyPasswordState:KBModifyPasswordStateEnd];
    }
}

- (void)messageAction
{
    if ([self.mLoginNewIphoneInputView inputText].length == 0) {
        [self alterMessage:kInputFullString];
        return;
    }
    if ([self.mLoginNewIphoneInputView inputText].length != 11) {
        [self alterMessage:kInputIphoneString];
        return;
    }
    if (self.delegate  && [self.delegate respondsToSelector:@selector(callSmsCodeIphoneInput:)]) {
        [self.delegate callSmsCodeIphoneInput:[self.mLoginNewIphoneInputView inputText]];
    }
}
#pragma mark setter getter

- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       _bottomBtn.frame = CGRectMake(40,305, self.ct_width-80, 40);
        _bottomBtn.backgroundColor = kMainColor;
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = 4;
        [_bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn addTarget:self action:@selector(nextActon) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_bottomBtn];
    }
 
    return _bottomBtn;
}

- (UIButton *)messageBtn
{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.frame = CGRectMake(self.mMessageInputView.ct_right+20,self.mMessageInputView.ct_top, self.mLoginPasswordInputView.ct_width-self.mMessageInputView.ct_width-20, 40);
        _messageBtn.backgroundColor = kMainColor;
        _messageBtn.layer.masksToBounds = YES;
        _messageBtn.layer.cornerRadius = 4;
        [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _messageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _messageBtn;
}

- (UILabel *)tipLable
{
    if (!_tipLable) {
        _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width-200-40, self.messageBtn.ct_bottom+10, 200, 11)];
        _tipLable.textAlignment = NSTextAlignmentRight;
        _tipLable.textColor = KBCOLOR_WITH_HEX(0x666666);
        _tipLable.font = [UIFont systemFontOfSize:12];
        _tipLable.text = @"TIPS:验证码10分钟内有效";
    }
    return _tipLable;
}

- (UIImageView *)doneImageView
{
    if (!_doneImageView) {
        _doneImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.ct_width-77)/2, kProcessViewHeight+33, 77, 77)];
        _doneImageView.image = [UIImage imageNamed:@"done"];
    }
    return _doneImageView;
}

- (UITextView *)doneIphoneLable
{
    if (!_doneIphoneLable) {
        _doneIphoneLable = [[UITextView alloc]initWithFrame:CGRectMake(40, self.doneImageView.ct_bottom+33, self.ct_width-80, 80)];
        _doneIphoneLable.textColor = KBCOLOR_WITH_HEX(0x666666);
        _doneIphoneLable.editable = NO;
        _doneIphoneLable.font = [UIFont systemFontOfSize:14];
        _doneIphoneLable.text = @"当前手机号：117****0823\n\n您的手机号码已经修改成功啦，请您牢记并妥善保管您的账号信息哦！";
    }
    return _doneIphoneLable;
}

#pragma mark public

- (void)setModifyViewType:(KBModifyViewType)modifyViewType
{
    _modifyViewType = modifyViewType;
    
    if (modifyViewType == KBModifyViewTypeIphone)
    {
        self.array = @[@"验证密码",@"更换手机号",@"修改成功"];
        self.processView = [[KBProcessView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, kProcessViewHeight) titleArray:self.array];
        [self addSubview:self.processView];
        [self setupLoginInputView];
        [self addSubview:self.bottomBtn];
        self.modifyIphoneState = KBModifyIphoneStateLoginPassword;
    }
    else if (modifyViewType == KBModifyViewTypePassword)
    {
        self.array = @[@"验证密码",@"修改成功"];
        self.processView = [[KBProcessView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, kProcessViewHeight) titleArray:self.array];
        [self addSubview:self.processView];
        [self setupPasswordInputView];
        [self addSubview:self.bottomBtn];
        [self.bottomBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        self.modifyPasswordState = KBModifyPasswordStateStart;
    }
}

@end
