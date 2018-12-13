//
//  KBTaskHouseAgreeViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskHouseAgreeViewController.h"
#import "RoomDetailHandleView.h"
#import "RoomSheetView.h"
#import "AgentPickerView.h"
#import <Masonry.h>
@interface KBTaskHouseAgreeViewController ()
{
    UIScrollView *sv ;
}
@property (nonatomic,strong)RoomDetailHandleView *mainView;
@property (nonatomic,assign) NSInteger realtyid;
@property (nonatomic,strong) RoomSheetView *sheetView;
@property (nonatomic,strong) AgentPickerView *pickerView;
@property (nonatomic,strong) KBRoomModel * roomModel;
@property (nonatomic,strong) NSMutableArray * sourceArray;
@property (nonatomic,strong) NSMutableArray * tradeTypeArray;
@property (nonatomic,strong) NSMutableArray * rentUnitArray;
@property (nonatomic,strong) NSMutableArray * agentArray;

//=========
@property (nonatomic,copy) NSString *approvaid;
@property (nonatomic,copy) NSString *completedmemo;
@property (nonatomic,copy) NSString *sourcetype;
@property (nonatomic,copy) NSString *tradetype;
@property (nonatomic,copy) NSString *rentemployeeid;
@property (nonatomic,copy) NSString *saleemployeeid;
@property (nonatomic,copy) NSString *rentprice;
@property (nonatomic,copy) NSString *saleprice;
@property (nonatomic,copy) NSString *unitofrentprice;


@end

@implementation KBTaskHouseAgreeViewController

- (instancetype)initRealtyid:(NSInteger)realtyid approvaid:(NSString *)approvaid
{
    self = [super init];
    if (!self) return nil;
    self.realtyid = realtyid;
    self.sourceArray = [[NSMutableArray alloc] init];
    self.tradeTypeArray = [[NSMutableArray alloc] init];
    self.rentUnitArray = [[NSMutableArray alloc]init];
    self.agentArray = [[NSMutableArray alloc] init];
    self.approvaid = approvaid;
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sv.contentSize = CGSizeMake(self.view.ct_width, 1027);
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"审批通过"];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.ct_bottom, self.view.ct_width, 1)];
//    [self.view addSubview:view];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_bottom)];
    [self.view addSubview:sv];
    
    [sv addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(sv);
        make.width.mas_equalTo(sv.ct_width);
        make.bottom.equalTo(sv.mas_bottom);
    }];
    
    [self.view addSubview:self.sheetView];
    
    
    [self.sheetView setAutoLayoutLeftToViewLeft:sv constant:0];
    [self.sheetView setAutoLayoutRightToViewRight:sv constant:0];
    [self.sheetView setAutoLayoutTopToViewTop:sv constant:0];
    [self.sheetView setAutoLayoutBottomToViewBottom:sv constant:0];
    
    self.sheetView.hidden = YES;
    
    
    [self.view addSubview:self.pickerView];
    
    [self.pickerView setAutoLayoutLeftToViewLeft:sv constant:0];
    [self.pickerView setAutoLayoutRightToViewRight:sv constant:0];
    [self.pickerView setAutoLayoutTopToViewTop:sv constant:0];
    [self.pickerView setAutoLayoutBottomToViewBottom:sv constant:0];
    
    self.pickerView.hidden = YES;

    [self api];
     @KBWeakObj(self);
    self.sheetView.didSelectedBlock = ^(NSInteger index) {
        @KBStrongObj(self);
        [self  handSheetIndex:index sheetViewType:self.sheetView.sheetViewType];
    };
    
   
    self.mainView.agreeBlock = ^{
        @KBStrongObj(self);
//        if (self.agreeControllerBlock) {
//            self.agreeControllerBlock(self.mainView.inputTextView.text);
//        }
        self.completedmemo = self.mainView.inputTextView.text;
        [self submit];
    };
    self.mainView.rentTypeBlock = ^{
        @KBStrongObj(self);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.tradeTypeArray enumerateObjectsUsingBlock:^(KBRoomRentingSelling *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:model.Value];
        }];
        self.sheetView.sheetViewType = KBSheetViewTypeRentType;
        [self.sheetView setDataArray:array];
        self.sheetView.hidden = NO;
    };
    self.mainView.rentUnitBlock = ^{
        @KBStrongObj(self);
        self.sheetView.sheetViewType = KBSheetViewTypeRentUnit;
        [self.sheetView setDataArray:self.rentUnitArray];
        self.sheetView.hidden = NO;
    };
    self.mainView.sourceBlock = ^{
        @KBStrongObj(self);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        self.sheetView.sheetViewType = KBSheetViewTypeSource;
        [self.sourceArray enumerateObjectsUsingBlock:^(KBRoomOtherSource *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:model.Value];
        }];
        [self.sheetView setDataArray:array];
        self.sheetView.hidden = NO;
    };
    
    self.mainView.renterBlock = ^{
        @KBStrongObj(self);
        self.pickerView.sheetViewType = KBSheetViewTypeRenter;
        self.pickerView.hidden = NO;
        [self.pickerView setArray:self.agentArray];
        
    };
    
    self.mainView.sellerBlock = ^{
        @KBStrongObj(self);
        self.pickerView.sheetViewType = KBSheetViewTypeSeller;
        self.pickerView.hidden = NO;
        [self.pickerView setArray:self.agentArray];
    };
    
    self.pickerView.didPickerBlock = ^(NSString *shopName, NSString *name, NSString *accountId) {
        @KBStrongObj(self);
        if (self.pickerView.sheetViewType == KBSheetViewTypeRenter )
        {
            [self.mainView.btnRenter setTitle: [self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@",shopName,name]] forState:UIControlStateNormal];
            self.rentemployeeid = accountId;
             NSLog(@"租赁人 -------- %@ ----%@",name, self.rentemployeeid);
           
        }
        else if (self.pickerView.sheetViewType == KBSheetViewTypeSeller )
        {
            [self.mainView.btnSeller setTitle: [self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@",shopName,name]] forState:UIControlStateNormal];
            self.saleemployeeid = accountId;
              NSLog(@"出售人 -------- %@ ----%@",name, self.saleemployeeid);
        }
    };
   
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(sv);
        make.width.mas_equalTo(sv.ct_width);
        make.bottom.equalTo(sv.mas_bottom);
    }];
    
}

- (void)submit
{
    if (self.mainView.textFieldRentPrice.text.length == 0) {
        [KBAlter show:@"请输入租价" superView:self.view];
        return;
    }
    if (self.mainView.textFieldSellPrice.text.length == 0) {
        [KBAlter show:@"请输入售价" superView:self.view];
        return;
    }
    self.rentprice = self.mainView.textFieldRentPrice.text;
    self.saleprice = self.mainView.textFieldSellPrice.text;

    [[KBApiLayer sharedInstance] taskHourseAgreeApprovaid:self.approvaid
                                            completedmemo:self.completedmemo
                                               sourcetype:self.sourcetype
                                                tradetype:self.tradetype
                                           rentemployeeid:self.rentemployeeid
                                           saleemployeeid:self.saleemployeeid
                                                rentprice:self.rentprice
                                                saleprice:self.saleprice
                                          unitofrentprice:self.unitofrentprice
                                            RentUnitPrice:self.roomModel.data.roomdetails.RentUnitPrice
                                      UnitofRentUnitPrice:self.roomModel.data.roomdetails.UnitofRentUnitPrice
                                            SaleUnitPrice:self.roomModel.data.roomdetails.SaleUnitPrice
                                         ConstructionArea:self.roomModel.data.roomdetails.ConstructionArea
                                                  success:^(KBBaseModel * model) {
                                                      if (model.code == 0) {
                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                              [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                                                          });
                                                      }
                                                      
        [KBAlter show:model.desc superView:self.view];
    } fail:^(NSError *error) {
        
    }];
}



- (void)handleTradType:(NSString *)tradeType
{
    if ([tradeType integerValue] == 0) {
        self.mainView.btnRenter.enabled = YES;
        self.mainView.btnSeller.enabled = NO;
        
        self.mainView.textFieldSellPrice.enabled = NO;
        self.mainView.textFieldRentPrice.enabled = YES;
        
        [self.mainView.btnSeller setTitle:@"  不可选择" forState:UIControlStateNormal];
//        self.mainView.btnSeller.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
//        self.mainView.btnRenter.backgroundColor = [UIColor clearColor];
        if ([self.mainView.btnRenter.titleLabel.text isEqualToString:@"  不可选择"]) {
            [self.mainView.btnRenter setTitle: [self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", self.roomModel.data.roomdetails.RentShopName, self.roomModel.data.roomdetails.RentEmployeeName]] forState:UIControlStateNormal];
        }
    }
    else if ([tradeType integerValue] == 1) {
        self.mainView.btnRenter.enabled = NO;
        self.mainView.btnSeller.enabled = YES;
        self.mainView.textFieldSellPrice.enabled = YES;
        self.mainView.textFieldRentPrice.enabled = NO;
        [self.mainView.btnRenter setTitle:@"  不可选择" forState:UIControlStateNormal];
//        self.mainView.btnRenter.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
//        self.mainView.btnSeller.backgroundColor = [UIColor clearColor];
        if ([self.mainView.btnSeller.titleLabel.text isEqualToString:@"  不可选择"]) {
            [self.mainView.btnSeller setTitle:[self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", self.roomModel.data.roomdetails.SaleShopName, self.roomModel.data.roomdetails.SaleEmployeeName]] forState:UIControlStateNormal];
        }
    }
    else if ([tradeType integerValue] == 2) {
        self.mainView.btnRenter.enabled = YES;
        self.mainView.btnSeller.enabled = YES;
        self.mainView.textFieldSellPrice.enabled = YES;
        self.mainView.textFieldRentPrice.enabled = YES;
//        self.mainView.btnSeller.backgroundColor = [UIColor clearColor];
//        self.mainView.btnRenter.backgroundColor = [UIColor clearColor];
        if ([self.mainView.btnSeller.titleLabel.text isEqualToString:@"  不可选择"]) {
            [self.mainView.btnSeller setTitle:[self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", self.roomModel.data.roomdetails.SaleShopName, self.roomModel.data.roomdetails.SaleEmployeeName]] forState:UIControlStateNormal];
        }
        if ([self.mainView.btnRenter.titleLabel.text isEqualToString:@"  不可选择"]) {
            [self.mainView.btnRenter setTitle: [self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", self.roomModel.data.roomdetails.RentShopName, self.roomModel.data.roomdetails.RentEmployeeName]] forState:UIControlStateNormal];
        }
    }
}
- (void)handSheetIndex:(NSInteger) index sheetViewType:(KBSheetViewType)type
{
    switch (type) {
            case KBSheetViewTypeSource:
        {
            KBRoomOtherSource *model = [self.sourceArray objectAtIndex:index];
            [self.mainView.sourceBtn setTitle:[self getTwoSpaceString:model.Value] forState:UIControlStateNormal];
            self.sourcetype = model.Key;
            NSLog(@"来源----%@ ------- %@",model.Value,self.sourcetype);
        }
            break;
            case KBSheetViewTypeRentUnit:
        {
            NSString  *string = [self.rentUnitArray objectAtIndex:index];
            [self.mainView.rentUnitBtn setTitle:[self getTwoSpaceString:string] forState:UIControlStateNormal];
            self.unitofrentprice = string;
             NSLog(@"单位----%@", self.unitofrentprice);
        }
            break;
            case KBSheetViewTypeRentType:
        {
            KBRoomRentingSelling *model = [self.tradeTypeArray objectAtIndex:index];
            [self.mainView.RentTypeBtn setTitle:[self getTwoSpaceString:model.Value] forState:UIControlStateNormal];
            self.tradetype = model.Key;
            NSLog(@"租赁类型 -------- %@ ----%@",model.Value, self.tradetype);
            [self handleTradType:model.Key];
        }
            break;
            case KBSheetViewTypeRenter:
        {
            
        }
            break;
            case KBSheetViewTypeSeller:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)api
{
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskRoomDetailRealtyid:self.realtyid success:^(KBRoomModel * model) {
        [KBAlter hideLoadingForView:self.view];
        self.mainView.houseCode.text = [NSString stringWithFormat:@"房源编号：%@",model.data.roomdetails.RealtyNum];
        self.mainView.propertyName.text = [NSString stringWithFormat:@"物业名称：%@",model.data.roomdetails.AreaName];
        self.mainView.address.text = [NSString stringWithFormat:@"地       址：%@",model.data.roomdetails.Address];
        self.mainView.propertyType.text = [NSString stringWithFormat:@"物业名称：%@",model.data.roomdetails.CommunityName];
        self.mainView.houseType.text  = [NSString stringWithFormat:@"户       型：%@ 室 %@ 厅 %@ 卫 %@ 阳台",model.data.roomdetails.RoomNums,model.data.roomdetails.LivingRoomNums,model.data.roomdetails.ToiletNums,model.data.roomdetails.BalconyNums];
        self.mainView.area.text = [NSString stringWithFormat:@"  面      积：%@",[NSString stringWithFormat:@"%@㎡",model.data.roomdetails.ConstructionArea]];
        self.mainView.orientations.text = [NSString stringWithFormat:@"朝      向：%@",model.data.roomdetails.strFaceOrientation];
        self.mainView.architecturalType.text = [NSString stringWithFormat:@"建筑类型：%@",model.data.roomdetails.ConstructionType];
        self.mainView.houseYear.text = [NSString stringWithFormat:@"房本年限：%@",[NSString stringWithFormat:@"%@年",model.data.roomdetails.CertificationYears]];
        self.mainView.statusLable.text = [NSString stringWithFormat:@"流通状态：%@",model.data.roomdetails.strRealtyStatus];
        [self.mainView.rentUnitBtn setTitle:model.data.roomdetails.UnitofRentPrice forState:UIControlStateNormal];
        [self.mainView.sourceBtn setTitle:[self getTwoSpaceString:model.data.roomdetails.strSourceType]  forState:UIControlStateNormal];
        [self.mainView.RentTypeBtn  setTitle:[self getTwoSpaceString:model.data.roomdetails.strTradeType]  forState:UIControlStateNormal];
        self.mainView.textFieldRentPrice.text = model.data.roomdetails.RentPrice;
        self.mainView.textFieldSellPrice.text = model.data.roomdetails.SalePrice;
       
        [self.mainView.btnRenter setTitle: [self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", model.data.roomdetails.RentShopName, model.data.roomdetails.RentEmployeeName]] forState:UIControlStateNormal];
        [self.mainView.btnSeller setTitle:[self getTwoSpaceString:[NSString stringWithFormat:@"%@ %@", model.data.roomdetails.SaleShopName, model.data.roomdetails.SaleEmployeeName]] forState:UIControlStateNormal];
        [self transitionToViewArray:model];
        [self transitionToDefault:model];
        
        self.roomModel = model;
        
        NSDictionary *FieldPermission = model.data.roomdetails.FieldPermission;
        if ([FieldPermission[@"SourceTypession"] integerValue] != 1) {
            self.mainView.sourceBtn.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.sourceBtn.userInteractionEnabled = NO;
            [self.mainView.sourceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        } else {
            self.mainView.sourceBtn.backgroundColor = [UIColor clearColor];
            self.mainView.sourceBtn.userInteractionEnabled = YES;
            [self.mainView.sourceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([FieldPermission[@"TradeTypession"] integerValue] != 1) {
            self.mainView.RentTypeBtn.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.RentTypeBtn.userInteractionEnabled = NO;
            [self.mainView.RentTypeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        } else {
            self.mainView.RentTypeBtn.backgroundColor = [UIColor clearColor];
            self.mainView.RentTypeBtn.userInteractionEnabled = YES;
            [self.mainView.RentTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([FieldPermission[@"RentEmployeeNamession"] integerValue] != 1) {
            self.mainView.btnRenter.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.btnRenter.userInteractionEnabled = NO;
            [self.mainView.btnRenter setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        } else {
            self.mainView.btnRenter.backgroundColor = [UIColor clearColor];
            self.mainView.btnRenter.userInteractionEnabled = YES;
            [self.mainView.btnRenter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([FieldPermission[@"SaleEmployeeNamession"] integerValue] != 1) {
            self.mainView.btnSeller.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.btnSeller.userInteractionEnabled = NO;
            [self.mainView.btnSeller setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        } else {
            self.mainView.btnSeller.backgroundColor = [UIColor clearColor];
            self.mainView.btnSeller.userInteractionEnabled = YES;
            [self.mainView.btnSeller setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([FieldPermission[@"RentPricession"] integerValue] != 1) {
            self.mainView.textFieldRentPrice.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.textFieldRentPrice.userInteractionEnabled = NO;
            self.mainView.textFieldRentPrice.textColor = [UIColor darkGrayColor];
        } else {
            self.mainView.textFieldRentPrice.backgroundColor = [UIColor clearColor];
            self.mainView.textFieldRentPrice.userInteractionEnabled = YES;
            self.mainView.textFieldRentPrice.textColor = [UIColor blackColor];
        }
        
        if ([FieldPermission[@"UnitofRentPricession"] integerValue] != 1) {
            self.mainView.rentUnitBtn.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.rentUnitBtn.userInteractionEnabled = NO;
            [self.mainView.rentUnitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        } else {
            self.mainView.rentUnitBtn.backgroundColor = [UIColor clearColor];
            self.mainView.rentUnitBtn.userInteractionEnabled = YES;
            [self.mainView.rentUnitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([FieldPermission[@"SalePricession"] integerValue] != 1) {
            self.mainView.textFieldSellPrice.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
            self.mainView.textFieldSellPrice.userInteractionEnabled = NO;
            self.mainView.textFieldSellPrice.textColor = [UIColor darkGrayColor];
        } else {
            self.mainView.textFieldSellPrice.backgroundColor = [UIColor clearColor];
            self.mainView.textFieldSellPrice.userInteractionEnabled = YES;
            self.mainView.textFieldSellPrice.textColor = [UIColor blackColor];
        }
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (void)transitionToDefault:(KBRoomModel * ) model
{
    self.sourcetype = model.data.roomdetails.sourcetype;
    self.tradetype  = model.data.roomdetails.tradetype;
    self.rentemployeeid = model.data.roomdetails.rentemployeeid;
    self.saleemployeeid = model.data.roomdetails.saleemployeeid;
    self.rentprice = model.data.roomdetails.rentprice;
    self.saleprice  = model.data.roomdetails.saleprice;
    self.unitofrentprice = model.data.roomdetails.UnitofRentPrice;
    [self handleTradType:model.data.roomdetails.tradetype];
}


- (void)transitionToViewArray:(KBRoomModel * ) model
{
   [self.sourceArray  addObjectsFromArray:model.data.dropdowndata.source];
   [self.tradeTypeArray addObjectsFromArray:model.data.dropdowndata.rentingselling];
   [self.rentUnitArray addObjectsFromArray:model.data.dropdowndata.rental];
   [self.agentArray  addObjectsFromArray:model.data.dropdowndata.agentlist];
    
}

- (NSString *)getTwoSpaceString:(NSString *)string
{
    return [NSString stringWithFormat:@"  %@",string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RoomDetailHandleView *)mainView {
    if (!_mainView) {
        _mainView = [RoomDetailHandleView loadViewFrom:@"RoomDetailHandleView"];
    }
    return _mainView;
}

- (RoomSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [RoomSheetView loadViewFrom:@"RoomSheetView"];
    }
    return _sheetView;
}

- (AgentPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [AgentPickerView loadViewFrom:@"AgentPickerView"];
    }
    return _pickerView;
}



@end
