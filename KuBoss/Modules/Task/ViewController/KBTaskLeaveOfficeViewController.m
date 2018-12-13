//
//  KBTaskLeaveOfficeViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskLeaveOfficeViewController.h"
#import "LeaveOfficeView.h"

@interface KBTaskLeaveOfficeViewController ()
@property (nonatomic,assign) NSInteger accountid;
@property (nonatomic,strong)LeaveOfficeView *mainView;
@property (nonatomic,copy) NSString * agentName;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSString *curentDateString;
@property (nonatomic, strong) NSString *submitCurentDateString;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)KBHandleLeaveOfficeModel * leaveOfficeModel;
@end

@implementation KBTaskLeaveOfficeViewController
- (instancetype)initWithAccountid:(NSInteger)accountid agentName:(NSString *)agentName
{
    self = [super init];
    if (!self) return nil;
    self.accountid = accountid;
    self.agentName = agentName;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"离职处理"];
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    
    [self api];
     @KBWeakObj(self);
    self.mainView.submitBlock = ^(NSString *string) {
        @KBStrongObj(self);
        [self submitApi:string];
    };
    
    self.mainView.dateBlock = ^{
        @KBStrongObj(self);
        self.datePicker.hidden = NO;
        self.topView.hidden = NO;
    };
    
    [self setupDateKeyPan];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd";
    self.submitCurentDateString = [formatter1  stringFromDate:[NSDate date]];
    

 
}

- (void)setupDateKeyPan {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.ct_height-200,  self.view.ct_width, 200)];
    datePicker.backgroundColor = [UIColor whiteColor];
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    
    //设置时间格式
    
    //监听DataPicker的滚动
    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker = datePicker;
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0,  self.view.ct_height-200-40, self.view.ct_width, 40)];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = KBCOLOR_WITH_HEX(0xF9f9f9);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 40);
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(self.view.ct_width-80, 0, 80, 40);
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn1 addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn1];
    
    self.datePicker.hidden = YES;
    self.topView.hidden = YES;
    
    
}

- (void)cancel
{
    self.datePicker.hidden = YES;
    self.topView.hidden = YES;
}

- (void)sure
{
    [self.mainView.dateBtn setTitle: self.curentDateString forState:UIControlStateNormal];
    self.datePicker.hidden = YES;
    self.topView.hidden = YES;
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"   yyyy.MM.dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    self.curentDateString = dateStr;
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd";
    self.submitCurentDateString = [formatter1  stringFromDate:datePicker.date];
  
}



- (void)submitApi:(NSString *)string
{
    if(!self.leaveOfficeModel.data.accountid)
    {
        [KBAlter show:@"accountid 为空"superView:self.view];
        return;
    }
    
    if(!self.approvaid)
    {
        [KBAlter show:@"approvaid 为空"superView:self.view];
        return;
    }
    [[KBApiLayer sharedInstance]  taskHandleLeaveOfficeAccountid:self.leaveOfficeModel.data.accountid
                                                          reason:string
                                                       approvaid:self.approvaid
                                                  separationdate:self.submitCurentDateString success:^(KBBaseModel* model) {
                                                      if(model.code == 0){
//                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                          UIViewController *vc =  self.navigationController.childViewControllers[1];
                                                          [self.navigationController popToViewController:vc animated:YES];
                                                      }
                                                      
        [KBAlter show:model.desc superView:self.view];
    } fail:^(NSError *error) {
        [KBAlter showLoadingForView:self.view];
    }];
}

- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskHandleLeaveOfficeAccountid:self.accountid success:^(KBHandleLeaveOfficeModel * model) {
        @KBStrongObj(self);
        self.leaveOfficeModel = model;
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}


- (LeaveOfficeView *)mainView {
    if (!_mainView) {
        _mainView = [LeaveOfficeView loadViewFrom:@"LeaveOfficeView"];
    }
    return _mainView;
}


@end
