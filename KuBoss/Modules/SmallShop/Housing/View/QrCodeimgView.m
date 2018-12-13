//
//  QrCodeimgView.m
//  ddcp
//
//  Created by lidan on 2018/5/17.
//  Copyright © 2018年 xyf. All rights reserved.
//

#import "QrCodeimgView.h"
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
@interface QrCodeimgView ()<UIGestureRecognizerDelegate>
{
    UIImageView   *_imgview;
    UIView        *_whiteview;
    UILabel       *_lbQrNo;
}

@property (nonatomic , strong)UIAlertView *myAlertView;
@property (nonatomic , strong)UIAlertView *myAlertView2;
@property (nonatomic, copy) void(^action)(NSInteger index);

@end
@implementation QrCodeimgView
- (instancetype)initWithimgurl:(NSDictionary *)dic action:(void(^)(NSInteger index))action{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alpha = 0;
        _urlstr=dic[@"img"];
        // 添加手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//        tap.delegate = self;
//        [self addGestureRecognizer:tap];
        self.action = action;

        _whiteview=[[UIView alloc]initWithFrame:CGRectMake(40, 100, MSW-80, 400)];
        _whiteview.backgroundColor=[UIColor whiteColor];
        [self addSubview:_whiteview];
        
        UILabel*  _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _whiteview.width - 20, 20)];
        _titleLab.textColor = blackTextColor;
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text=@"任务二维码";
        [_whiteview addSubview:_titleLab];
        
        _lbQrNo = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLab.bottom+10, _whiteview.width - 20, 20)];
        _lbQrNo.textColor = blackTextColor;
        _lbQrNo.font = [UIFont systemFontOfSize:16];
        _lbQrNo.textAlignment = NSTextAlignmentCenter;
        _lbQrNo.text=[NSString stringWithFormat:@"微信号：%@",dic[@"title"]];
        [_whiteview addSubview:_lbQrNo];
        
        
        _imgview=[[UIImageView alloc]initWithFrame:CGRectMake(40, _lbQrNo.bottom+10, _whiteview.width-80, _whiteview.width-80)];
        [_whiteview addSubview:_imgview];
//        [_imgview sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:kDEFOUT_IMAGE_1_1];
        _imgview.tag=10001;
        _imgview.userInteractionEnabled=YES;
        //长按
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPassAction:)];
        [_imgview addGestureRecognizer:longPress];
        //判定为长按手势 需要的时间
        longPress.minimumPressDuration = 1;
        //判定时间,允许用户移动的距离
        longPress.allowableMovement = 100;
        
        
        
        UILabel*  _desLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgview.bottom+10, _whiteview.width - 20, 20)];
        _desLab.textColor = blackTextColor;
        _desLab.font = [UIFont systemFontOfSize:16];
        _desLab.textAlignment = NSTextAlignmentCenter;
        _desLab.text=@"长按保存图片";
        [_whiteview addSubview:_desLab];
        
        UILabel*lbline=[[UILabel alloc]initWithFrame:CGRectMake(0, _desLab.bottom+10, _whiteview.width, 1)];
        lbline.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_whiteview addSubview:lbline];
        
      UIButton *  _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,lbline.bottom, _whiteview.width, 40);
//        _bottomBtn.backgroundColor = blackTextColor;
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn setTitleColor:blackTextColor forState:UIControlStateNormal];
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(clicksure) forControlEvents:UIControlEventTouchUpInside];
        [_whiteview addSubview:_bottomBtn];
        
        _whiteview.layer.masksToBounds = YES;
        _whiteview.layer.cornerRadius = 5;
        _whiteview.frame=CGRectMake(40, 100, MSW-80, _bottomBtn.bottom);
    }
    return self;
    
}

+ (void)showWithimgurl:(NSDictionary *)dic action:(void(^)(NSInteger index))action{
    
    QrCodeimgView *view = [[QrCodeimgView alloc] initWithimgurl:dic action:action];
    [view show];
    
}


//长按手势
- (void)longPassAction:(UILongPressGestureRecognizer *)longPress{
//    NSLog(@"11111");
    //长按手势
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您要保存当前图片到相册中吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [self.myAlertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // 保存照片(获取到点击的 image)
        //        NSInteger i = self.scroll.contentOffset.x / self.scroll.bounds.size.width;
        UIImageView *myImageView = (UIImageView *)[self viewWithTag:10001];
        UIImageWriteToSavedPhotosAlbum(myImageView.image, self, @selector(image:didFinshSavingWithError:contextInfo:), nil);
    }
    
}

// 保存图片错误提示方法
- (void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *mes = nil;
    if (error != nil) {
        mes = @"保存图片失败";
    } else {
        mes = @"保存图片成功";
    }
    self.myAlertView2 = [[UIAlertView alloc] initWithTitle:@"提示" message:mes delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [self.myAlertView2 show];
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
}

- (void)performDismiss:(NSTimer *)timer
{
    [self.myAlertView2 dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)clicksure{
    [self hide];

    if (_action) {
        _action(0);
    }
}


- (void)tap {
    [self hide];
}
#pragma mark - show or hide
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    // 向右下transform
//    _imgview.layer.anchorPoint = CGPointMake(1, 0);
    _whiteview.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        _whiteview.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _whiteview.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [_whiteview removeFromSuperview];
        [self removeFromSuperview];
      
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
