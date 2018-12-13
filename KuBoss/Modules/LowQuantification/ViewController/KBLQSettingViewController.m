//
//  KBLQSettingViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQSettingViewController.h"
#import "UIView+Shadow.h"
#import "KBCustomDatePickerView.h"
#import "KBLQDetailViewController.h"
#import "KBLQSettingViewCell.h"
#import "KBLQUserConfigRequest.h"

@interface KBLQSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)BOOL isWeek;
@property (nonatomic,strong)KBCustomDatePickerView  *datePickerView;
@property (nonatomic,strong)UILabel *topRightLable;
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSString *currentdate;
@property (nonatomic,strong) NSString *arrayString;

@end
@implementation KBLQSettingViewController


- (instancetype)initWithBool:(BOOL) isWeek
{
    self = [super init];
    if(!self) return nil;
    self.list = [[NSMutableArray alloc] init];
    self.isWeek = isWeek;
    self.arrayString = nil;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.isWeek)
    {
        [self setCustomTitle:@"每周低量化设置"];
    }
    else
    {
        [self setCustomTitle:@"每月低量化设置"];
    }
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self loadConfig];
    // Do any additional setup after loading the view.
}

- (void)loadConfig
{
//    @KBWeakObj(self);
    
    KBLQUserConfigRequest *request = [[KBLQUserConfigRequest alloc] initWithUserid:[KBUserInfoModel uid] noticetype:self.isWeek ? @"0" : @"1"];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        NSLog(@"%@", dict);
        KBLQUserConfigModel *model = [KBLQUserConfigModel yy_modelWithDictionary:dict];
        if(self.isWeek)
        {
            self.currentdate = model.data.weeklyremindertime;
            self.topRightLable.text =   [NSString stringWithFormat:@"每周一 %@",model.data.weeklyremindertime];
        }
        else
        {
            self.currentdate = model.data.monthremindingtime;
            self.topRightLable.text = [NSString stringWithFormat:@"1号 %@",model.data.monthremindingtime];
        }
        
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:model.data.mdxx];
        [self.tbView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
//    [KBAlter showLoadingForView:self.view];
//    [[KBApiLayer sharedInstance] lqConfigSuccess:^(KBLQUserConfigModel * model) {
//        @KBStrongObj(self);
//        [KBAlter hideLoadingForView:self.view];
//
//        if(self.isWeek)
//        {
//            self.currentdate = model.data.weeklyremindertime;
//            self.topRightLable.text =   [NSString stringWithFormat:@"每周一 %@",model.data.weeklyremindertime];
//        }
//        else
//        {
//            self.currentdate = model.data.monthremindingtime;
//            self.topRightLable.text = [NSString stringWithFormat:@"1号 %@",model.data.monthremindingtime];
//        }
//
//        [self.list removeAllObjects];
//        [self.list addObjectsFromArray:model.data.mdxx];
//        [self.tbView reloadData];
//
//    } fail:^(NSError *error) {
//        [KBAlter hideLoadingForView:self.view];
//    }];
}

- (void)saveDate:(NSString *)date
{
    self.currentdate = date;
    [self request];
 
}

- (void)request
{
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [self.list enumerateObjectsUsingBlock:^(KBLQUserShopModel * shopModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
        if (shopModel.officeid) {
            [dic setValue:shopModel.officeid forKey:@"officeid"];
        }
        if (shopModel.reminding) {
            [dic setValue:shopModel.reminding forKey:@"reminding"];
        }
        [array addObject:dic];
        
    }];
    
    NSError* error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.arrayString = jsonString;
    if(self.isWeek)
    {
        [[KBApiLayer sharedInstance]  lqSaveConfigweeklyReminderTime:self.currentdate monthRemindingTime:nil remindingz:1 remindingy:0 listString:jsonString noticetype:0   success:^(KBBaseModel * model) {
            [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
            // [KBAlter show:model.desc superView:self.view];
        }];
    }
    else
    {
        [[KBApiLayer sharedInstance]  lqSaveConfigweeklyReminderTime:nil monthRemindingTime:self.currentdate remindingz:0 remindingy:1 listString:jsonString  noticetype:1  success:^(KBBaseModel * model) {
            [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
            //            [KBAlter hideLoadingForView:self.view];
        }];
    }
    
    
}

- (void)tapDate
{
    //self.datePickerView.hidden = !self.datePickerView.hidden;
}


- (void)setupSubViews
{
    UIView *topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 11, self.view.ct_width, 60)];
    topBackView.backgroundColor = [UIColor whiteColor];
    [topBackView shadow];
    [self.view addSubview:topBackView];
    
    UILabel *topLeftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, self.view.ct_width-30, 15)];
    topLeftLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    topLeftLable.font = [UIFont systemFontOfSize:14];
    topLeftLable.text = @"预警提醒时间";
    [topBackView addSubview:topLeftLable];
    
    
    self.topRightLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.ct_width-215, 20, 200, 15)];
    self.topRightLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.topRightLable.font = [UIFont systemFontOfSize:14];
    self.topRightLable.text = @"";
    self.topRightLable.textAlignment = NSTextAlignmentRight;
    [topBackView addSubview:self.topRightLable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDate)];
    tap.numberOfTapsRequired  = 1;
    tap.numberOfTouchesRequired = 1;
    self.topRightLable.userInteractionEnabled = YES;
    [self.topRightLable addGestureRecognizer:tap];
    
    
    UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(15, topBackView.ct_bottom+15, self.view.ct_width-30, 14)];
    topLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    topLable.font = [UIFont systemFontOfSize:13];
    topLable.text = @"每个低量化预警周期结束会收到系统推送。";
    [self.view addSubview:topLable];
    
    UILabel *topLable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, topLable.ct_bottom+15, self.view.ct_width-30, 14)];
    topLable1.textColor = KBCOLOR_WITH_HEX(0x999999);
    topLable1.font = [UIFont systemFontOfSize:13];
    topLable1.text = @"自动提醒经纪人";
    [self.view addSubview:topLable1];
    
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, topLable1.ct_bottom+15, self.view.ct_width, self.view.ct_height-(topLable1.ct_bottom+15)) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tableFooterView = [self footView];
    _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.tbView];
    
    [self.view addSubview:self.datePickerView];
    self.datePickerView.hidden = YES;
    @KBWeakObj(self);
    self.datePickerView.pickViewBlock = ^(NSString *hour, NSString *min) {
        @KBStrongObj(self);
        if(self.isWeek)
        {
            self.topRightLable.text = [NSString stringWithFormat:@"每周一 %@:%@",hour,min];
        }
        else
        {
            self.topRightLable.text = [NSString stringWithFormat:@"1号 %@:%@",hour,min];
        }
        
        [self saveDate:[NSString stringWithFormat:@"%@:%@",hour,min]];
        
    };
    
}


- (UIView *)footView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.view.ct_width-30, 60)];
    UILabel *footLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, footView.ct_width, 50)];
    footLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    footLable.font = [UIFont systemFontOfSize:13];
    footLable.numberOfLines = 2;
    footLable.text = @"开启后，当预警周期结束，自动向所有业务未达标的经纪人发送消息提醒。";
    [footView addSubview:footLable];
    return footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"cellId";
    KBLQSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[KBLQSettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KBLQUserShopModel *shopModel = [self.list objectAtIndex:indexPath.row];
    cell.bottomLeftLable.text =  shopModel.officename;
    if ([shopModel.reminding integerValue] == 1) {
        cell.switchView.on = YES;
    }
    else{
        cell.switchView.on = NO;
    }
    @KBWeakObj(self);
    cell.enableBlock = ^(BOOL isOn) {
        @KBStrongObj(self);
        if (isOn) {
            shopModel.reminding = @"1";
        }
        else{
            shopModel.reminding = @"0";
        }
        [self request:shopModel.officeid reminding:isOn];
    };
    cell.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.list.count - 1) {
        return 70;
    }
    return 55;
}

- (void)request:(NSString *)officeID reminding:(NSInteger)reminding
{
    

//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    [self.list enumerateObjectsUsingBlock:^(KBLQUserShopModel * shopModel, NSUInteger idx, BOOL * _Nonnull stop) {
//         NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
//        if (shopModel.officeid) {
//            [dic setValue:shopModel.officeid forKey:@"officeid"];
//        }
//        if (shopModel.reminding) {
//           [dic setValue:shopModel.reminding forKey:@"reminding"];
//        }
//        [array addObject:dic];
//
//    }];
//
//    NSError* error = nil;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    self.arrayString = jsonString;
    if(self.isWeek)
    {
        [[KBApiLayer sharedInstance]  lqSaveConfigweeklyReminderTime:self.currentdate monthRemindingTime:nil remindingz:reminding remindingy:0 listString:officeID noticetype:0   success:^(KBBaseModel * model) {
         [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
          // [KBAlter show:model.desc superView:self.view];
        }];
    }
    else
    {
        [[KBApiLayer sharedInstance]  lqSaveConfigweeklyReminderTime:nil monthRemindingTime:self.currentdate remindingz:reminding remindingy:1 listString:officeID  noticetype:1  success:^(KBBaseModel * model) {
            [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
//            [KBAlter hideLoadingForView:self.view];
        }];
    }
    
    
}

- (KBCustomDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView  = [[KBCustomDatePickerView alloc]initWithFrame:CGRectMake(0, self.view.ct_height-200, self.view.ct_width, 200)];
    }
    return _datePickerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
