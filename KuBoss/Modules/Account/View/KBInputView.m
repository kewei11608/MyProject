//
//  KBInputView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBInputView.h"
#import "KBHeader.h"

@interface KBInputView ()


@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *leftIcon;
@property (nonatomic,strong)UIImageView *rightIcon;

@property (nonatomic,copy) NSString *leftIconString;
@property (nonatomic,copy) NSString *rightIconString;
@property (nonatomic,assign) BOOL isTap;
@end
@implementation KBInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon   text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.leftIconString  =  leftIcon;
    self.rightIconString = rightIcon;
    self.bgView = [[UIView alloc]init];
    self.bgView.layer.cornerRadius = 20;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1.5;
    self.bgView.layer.borderColor = kMainColor.CGColor;
    [self addSubview:self.bgView];
    
    
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = text;
    self.textField.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.textField];
    [self setup];
    return self;
}

- (void)setBgRadius:(NSInteger) radius
{
    self.bgView.layer.cornerRadius = radius;
}

- (void)setup
{
   

    UIImage *leftImg = [UIImage imageNamed:self.leftIconString];
    UIImage *rightImg = [UIImage imageNamed:self.rightIconString];
    
    if (self.leftIconString ) {
        self.leftIcon = [[UIImageView alloc]init];
        self.leftIcon.image = [UIImage imageNamed:self.leftIconString];
        [self addSubview:self.leftIcon];
    }
    if (self.rightIconString) {
        self.rightIcon = [[UIImageView alloc]init];
        self.rightIcon.image = [UIImage imageNamed:self.rightIconString];
        [self addSubview:self.rightIcon];
    }
    
    @KBWeakObj(self);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
         @KBStrongObj(self);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        
    }];
    
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
         @KBStrongObj(self);
        make.left.equalTo(self.bgView).offset(11);
        make.top.equalTo(self.bgView).offset((self.ct_height-leftImg.size.height)/2);
        make.size.mas_equalTo(CGSizeMake(leftImg.size.width, leftImg.size.height));
    }];
    
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @KBStrongObj(self);
        make.right.equalTo(self.bgView).offset(-16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(rightImg.size.width, rightImg.size.height));
    }];
    
   
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @KBStrongObj(self);
        if (self.leftIconString )
        {
           make.left.equalTo(self.leftIcon.mas_right).offset(12);
        }
        else
        {
           make.left.equalTo(self.bgView).offset(12);
        }
        make.right.equalTo(self.bgView).offset(-11);
        make.top.equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    if (self.rightIconString) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        self.rightIcon.userInteractionEnabled = YES;
        [self.rightIcon addGestureRecognizer:tap];
        
    }
}

- (void)clickTap
{
    _isTap = !_isTap;
    self.textField.secureTextEntry = !_isTap;
    if (_isTap)
    {
        self.rightIcon.image = [UIImage imageNamed:@"openair"];
    }
    else
    {
        self.rightIcon.image = [UIImage imageNamed:self.rightIconString];
    }

}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

- (NSString *)inputText
{
    return self.textField.text;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}


@end
