//
//  KBManagerShopViewController.m
//  KuBoss
//
//  Created by sunruixue on 2018/4/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerShopViewController.h"
#import "KBSeletedControl.h"
#import "KBShopFilterView.h"
#import "KBBusinessShopHeadView.h"
#import "KBUpdateFootView.h"
#import "KBFilterDateView.h"
#import "KBManagerAgentViewController.h"
#import "MultiFormCell.h"

@interface KBManagerShopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)KBShopFilterView * shopFilterView;
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBBusinessShopHeadView *headView;
@property (nonatomic,strong)KBUpdateFootView *footView;
@property (nonatomic,strong)KBFilterDateView *filterView;
@property (nonatomic,strong)NSMutableArray *list;


@property (nonatomic,copy)NSString  *shopId;
@property (nonatomic,copy)NSString  *shopName;
@property (nonatomic,assign)NSInteger dataRange;
@property (nonatomic,assign)KBDateMode dateMode;
@property (nonatomic,assign)NSInteger housingType;
@property (nonatomic,strong)UIButton *shopBtn;
@property (nonatomic,strong)UILabel *totalLable;
@property (nonatomic,assign)BOOL isFirst;
@property (nonatomic,assign)BOOL isNew;
@property (nonatomic,strong)UIButton *dateBtn ;
@property (nonatomic,assign)float  offsetx ;
@end

@implementation KBManagerShopViewController

- (instancetype)initShopId:(NSString * )shopId shopName:(NSString *)shopName
{
    self = [super init];
    if (!self) return nil;
    self.shopId = shopId;
    self.dataRange = 1;
    self.dateMode = KBDateModeDay;
    self.housingType = 0;
    self.shopName  = shopName;
    
    if ([KBUserDefaultLayer getLeftFilterDate])
    {
        self.dateMode = [[KBUserDefaultLayer getLeftFilterDate]  integerValue]+1;
    };
    
    
    if ([KBUserDefaultLayer getTypeFilterDate]) {
        self.dataRange =  [[KBUserDefaultLayer getTypeFilterDate] integerValue];
    };
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        self.housingType = [[KBUserDefaultLayer getFilterHouseType] integerValue] - 100;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:tapCellScrollNotification object:nil];
    return self;
}

-(void)scrollMove:(NSNotification*)notification
{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    self.offsetx = x;
    obj = nil;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        NSString *str = [KBUserDefaultLayer getFilterHouseType];
        if ([str integerValue] == 102) {
            self.isNew = YES;
        }
        else{
            self.isNew = NO;
        }
    } ;
    self.view.backgroundColor = [UIColor  whiteColor];
    self.list = [[NSMutableArray alloc]init];
    [self createTitleButton];
    self.navigationController.navigationBar.topItem.title = @"";  
    
    KBSeletedControl *seletedControl = [[KBSeletedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, 50) titleArray:@[@"二手房",@"租赁",@"新房"]];
    seletedControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seletedControl];
    
    [self.view addSubview:self.tbView];
    
    self.dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dateBtn.frame = CGRectMake(self.view.ct_width -self.view.ct_width/2 , 0, self.view.ct_width/2, 50);
    self.dateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:[self getInitData]] forState:UIControlStateNormal];
    [self.dateBtn addTarget:self action:@selector(seletedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateBtn];
    
    [self.view addSubview:self.filterView];
    self.filterView.hidden = YES;
    
   
    @KBWeakObj(self);
    self.filterView.filterDateBlock = ^(KBDateMode mode, NSInteger type,NSString *data) {
        @KBStrongObj(self);
        
        if (KBDateModeDay == mode)
        {
            [KBUserBehavior  behaviorEventId:KBStoreYesterdaysDataEventId];
        }
        else if (KBDateModeWeek == mode)
        {
            [KBUserBehavior  behaviorEventId:KBStoreWeeklyDataEventId];
        }
        else if (KBDateModeMonth == mode)
        {
            [KBUserBehavior  behaviorEventId:KBStoreMonthlyDataEventId];
        }
        
        NSString *tilteString = [NSString stringWithFormat:@"%@ %@",data,[self getDateModeString:mode]];
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:tilteString] forState:UIControlStateNormal];
        self.dateMode = mode;
        self.dataRange = type;
        [self shopTimeType:self.dateMode officeid:self.shopId dataRange:self.dataRange housingType:self.housingType];
        
    };
    seletedControl.selectedIndexBlock = ^(UIButton *btn) {
        @KBStrongObj(self);
        self.housingType = btn.tag-100;
        if (btn.tag - 100 == 2) {
            self.headView.isNew = YES;
            self.isNew = YES;
        }
        else{
            self.headView.isNew = NO;
            self.isNew = NO;
        }
        [self shopTimeType:self.dateMode officeid:self.shopId dataRange:self.dataRange housingType:self.housingType];
    };
    
//    [self filteData];
//
//    [self shopTimeType:self.dateMode officeid:self.shopId dataRange:self.dataRange housingType:self.housingType];
    
    
    [self.headView setShopName:self.shopName];
    
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.height.equalTo(@40);
    }];
    
    [self.view addSubview:self.shopFilterView];
    self.shopFilterView.hidden = YES;
    
    self.shopFilterView.filterShopBlock = ^(NSString *shopId,NSString *shopName) {
         @KBStrongObj(self);
        self.shopName = shopName;
        [self setTitleName:@"down_arrow_dark"];
        self.shopId = shopId;
        [self shopTimeType:self.dateMode officeid:self.shopId dataRange:self.dataRange housingType:self.housingType];
    };
    
    
    
    self.filterView.hideSelfBlock = ^{
        @KBStrongObj(self);
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
    };
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior  behaviorEventId:KBEnterStorePageEventId];
    
    self.dataRange = 1;
    self.dateMode = KBDateModeDay;
    self.housingType = 0;
    
    if ([KBUserDefaultLayer getLeftFilterDate])
    {
        self.dateMode = [[KBUserDefaultLayer getLeftFilterDate]  integerValue]+1;
    };
    
    
    if ([KBUserDefaultLayer getTypeFilterDate]) {
        self.dataRange =  [[KBUserDefaultLayer getTypeFilterDate] integerValue];
    };
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        self.housingType = [[KBUserDefaultLayer getFilterHouseType] integerValue] - 100;
    }
    [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:[self getInitData]] forState:UIControlStateNormal];
    [self filteData];
    [self shopTimeType:self.dateMode officeid:self.shopId dataRange:self.dataRange housingType:self.housingType];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)filteData
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]   filterDateSuccess:^(KBFilterDateModel * filterModel) {
         @KBStrongObj(self);
        [self.filterView setFilterDataModel:filterModel];
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
    
}


- (void)shopTimeType:(NSInteger)timeType officeid:(NSString *)officeid dataRange:(NSInteger)dataRange housingType:(NSInteger)housingType
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  shopTimeType:timeType officeid:officeid dataRange:dataRange housingType:housingType success:^(KBShopModel * model) {
         @KBStrongObj(self);
        NSArray *array = model.data.zrzsj;
        if (array.count>0) {
            [self.headView setModel:array.firstObject];
        } else {
            [self.headView setModel:nil];
        }
        if (!self.isFirst) {
            [model.data.ggmdim enumerateObjectsUsingBlock:^(KBGgmdimModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([officeid isEqualToString:obj.officeid]) {
                    obj.isSame = YES;
                }
            }];
            [self.shopFilterView setShopList:model.data.ggmdim];
        }

        [self.list removeAllObjects];
        [self.list addObjectsFromArray:model.data.ggmdlist];
//        if (self.list.count == 0) {
//            self.headView.hidden = YES;
//        }
//        else{
             self.headView.hidden = NO;
//        }
        [self.tbView reloadData];
        [self.footView setTitle:model.data.gxsj];
        if (self.list.count != 0) {
//            self.tbView.tableFooterView = self.footView;
            self.footView.hidden = NO;
        }
        else{
//            self.tbView.tableFooterView = [UIView new];
            self.footView.hidden = YES;
        }
    
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
    
}

- (void)seletedAction
{
    if (!self.filterView.hidden) {
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
        
    }
    else{
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_light" string: [self getInitData]] forState:UIControlStateNormal];
        
    }
    self.filterView.hidden = !self.filterView.hidden;
}

- (void)setTitleName:(NSString *)imageName
{
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:self.shopName];
    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    textAttachment.image= [UIImage imageNamed:imageName];
    //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(0, -4, textAttachment.image.size.width, textAttachment.image.size.height);
    //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    
    self.totalLable.attributedText  = m_attributedString;
}

-(void)createTitleButton{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];

    self.totalLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    self.totalLable.font = [UIFont boldSystemFontOfSize:16];
    self.totalLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview: self.totalLable];
    
    [self setTitleName:@"down_arrow_dark"];
    
    self.totalLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedShop)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.totalLable addGestureRecognizer:tap];

    
    [self.navigationItem setTitleView:view];
}



- (void)selectedShop
{
  
    if (self.shopFilterView.hidden) {
        [self setTitleName:@"down_arrow_light"];
    }
    else
    {
         [self setTitleName:@"down_arrow_dark"];
    }
    self.shopFilterView.hidden = !self.shopFilterView.hidden;
}

- (KBShopFilterView *)shopFilterView
{
    if (!_shopFilterView) {
        _shopFilterView = [[KBShopFilterView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    }
    return _shopFilterView;
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *cellId = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
    MultiFormCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MultiFormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.isNew) {
        if (indexPath.row == 0) {
            [cell setArrayTitle:@[@"经纪人",@"排名",@"报备",@"确客",@"带看",@"认购",@"成交",@"业绩"]];
        }
        else{
    
            KBAgenListModel *model = [self.list objectAtIndex:indexPath.row-1];
            NSString *name =  model.agentname?model.agentname:@"0";
            NSString *name1 =  [NSString stringWithFormat:@"%ld",indexPath.row];
            NSString *name2 = model.addreportnumber?model.addreportnumber:@"0";
            NSString *name3 = model.addaccurateguestnumber?model.addaccurateguestnumber:@"0";
            NSString *name4 =  model.addtakealookinumber?model.addtakealookinumber:@"0";
            NSString *name5 = model.addsubscribenumber?model.addsubscribenumber:@"0";
            NSString *name6 =  model.agencysidesnumber?model.agencysidesnumber:@"0";
            name6 = [NSString stringWithFormat:@"%.f", [name6 doubleValue]];
           // NSString *name7 =  model.agencyperformance?model.agencyperformance:@"0";
            
           NSString * name7 = [NSString stringWithFormat:@"%.2f万",model.agencyperformance];
            [cell setArrayTitle:@[ name,name1,name2,name3,name4,name5,name6,name7]];
            
        }
    }
    else
    {
        if (indexPath.row == 0) {
            [cell setArrayTitle:@[@"经纪人",@"排名",@"房",@"客",@"勘",@"带",@"边",@"业绩"]];
        }
        else{
            KBAgenListModel *model = [self.list objectAtIndex:indexPath.row-1];
            NSString *name =  model.agentname?model.agentname:@"0";
            NSString *name1 =  [NSString stringWithFormat:@"%ld",indexPath.row];
            NSString *name2 = model.addavailabilitynumber?model.addavailabilitynumber:@"0";
            NSString *name3 = model.addtouristnumber?model.addtouristnumber:@"0";
            NSString *name4 =  model.addrealservicenumber?model.addrealservicenumber:@"0";
            NSString *name5 = model.addtakealookinumber?model.addtakealookinumber:@"0";
            NSString *name6 =  model.agencysidesnumber?model.agencysidesnumber:@"0";
            name6 = [NSString stringWithFormat:@"%.1f", [name6 doubleValue]];
            // NSString *name7 =  model.agencyperformance?model.agencyperformance:@"0";
            NSString * name7 = [NSString stringWithFormat:@"%.2f万",model.agencyperformance];
//            NSString * name7 = [NSString stringWithFormat:@"%.1f万",model.agencyperformance];
            [cell setArrayTitle:@[ name,name1,name2,name3,name4,name5,name6,name7]];
            
        }
    }
 
    if (indexPath.row%2!=0) {
        cell.backgroundColor = KBCOLOR_WITH_HEX(0xF5F5FA);
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    [cell scrollViewX:self.offsetx];;
    
  
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.list.count == 0) {
        return 0;
    }
    return self.list.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    [KBUserBehavior  behaviorEventId:KBClickAgentListEventId];
    KBAgenListModel *model = [self.list objectAtIndex:indexPath.row - 1];
    KBManagerAgentViewController *agent = [[KBManagerAgentViewController alloc] initAgentModel:model];
    [self.navigationController pushViewController:agent animated:YES];
}

 



- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame: CGRectMake(0, 50, self.view.ct_width, self.view.ct_height-40-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height-50) style:UITableViewStylePlain];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.headView;
//        _tbView.tableFooterView = self.footView;
        
    }
    
    return _tbView;
}

- (KBBusinessShopHeadView *)headView
{
    if (!_headView) {
        _headView = [[KBBusinessShopHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 330)];
        _headView.backgroundColor = [UIColor whiteColor];
    
        
    }
    return _headView;
}

- (KBUpdateFootView *)footView
{
    if (!_footView) {
        _footView = [[KBUpdateFootView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 40)];
    }
    return _footView;
}

- (KBFilterDateView *)filterView
{
    if (!_filterView) {
        _filterView = [[KBFilterDateView alloc]initWithFrame:CGRectMake(0, 60, self.view.ct_width, self.view.ct_height-60-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height
)];
    }
    return _filterView;
}






@end
