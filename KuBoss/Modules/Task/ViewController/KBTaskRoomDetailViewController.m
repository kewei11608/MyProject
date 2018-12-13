//
//  KBTaskRoomDetailViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskRoomDetailViewController.h"
#import "RoomDetailView.h"

@interface KBTaskRoomDetailViewController ()
@property (nonatomic,strong)RoomDetailView *mainView;
@property (nonatomic,assign) NSInteger realtyid;
@end

@implementation KBTaskRoomDetailViewController
- (instancetype)initRealtyid:(NSInteger)realtyid
{
    self = [super init];
    if (!self) return nil;
    self.realtyid = realtyid;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setCustomTitle:@"房源详情"];
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    [self api];
}



- (void)api
{
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskRoomDetailRealtyid:self.realtyid success:^(KBRoomModel * model) {
        [self handleData:model];
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (void)handleData:(KBRoomModel *) model
{

    NSMutableArray *array = [[NSMutableArray alloc] init];
   
    
    [array addObject:[self getPreString: @"房源编号:" postString:model.data.roomdetails.RealtyNum]];
    [array addObject:[self getPreString: @"物业名称:" postString:model.data.roomdetails.AreaName]];
    [array addObject:[self getPreString: @"地       址:" postString:model.data.roomdetails.Address]];
    [array addObject:[self getPreString: @"物业名称:" postString:model.data.roomdetails.CommunityName]];
    [array addObject:[self getPreString: @"户       型:" postString:[NSString stringWithFormat:@"%@ 室 %@ 厅 %@ 卫 %@ 阳台",model.data.roomdetails.RoomNums,model.data.roomdetails.LivingRoomNums,model.data.roomdetails.ToiletNums,model.data.roomdetails.BalconyNums]]];
    [array addObject:[self getPreString: @"面       积:" postString:[NSString stringWithFormat:@"%@㎡",model.data.roomdetails.ConstructionArea]]];
    [array addObject:[self getPreString: @"朝       向:" postString:model.data.roomdetails.strFaceOrientation]];
    [array addObject:[self getPreString: @"建筑类型:" postString:model.data.roomdetails.ConstructionType]];
    [array addObject:[self getPreString: @"房本年限:" postString:[NSString stringWithFormat:@"%@年",model.data.roomdetails.CertificationYears]]];
    [array addObject:[self getPreString: @"流通状态:" postString:model.data.roomdetails.strRealtyStatus]];
    [array addObject:[self getPreString: @"来       源:" postString:model.data.roomdetails.strSourceType]];
    [array addObject:[self getPreString: @"租售类型:" postString:model.data.roomdetails.strTradeType]];
    [array addObject:[self getPreString: @"租开盘人:" postString:[NSString stringWithFormat:@"%@ %@", model.data.roomdetails.RentShopName, model.data.roomdetails.RentEmployeeName]]];
    [array addObject:[self getPreString: @"售开盘人:" postString:[NSString stringWithFormat:@"%@ %@", model.data.roomdetails.SaleShopName, model.data.roomdetails.SaleEmployeeName]]];
    [array addObject:[self getPreString: @"租       价:" postString:[NSString stringWithFormat:@"%@%@", model.data.roomdetails.RentPrice, model.data.roomdetails.UnitofRentPrice]]];
    [array addObject:[self getPreString: @"售       价:" postString:[NSString stringWithFormat:@"%@万", model.data.roomdetails.SalePrice]]];
    [self.mainView setArray:array];
    
    
}

- (FreezeDetailCellModel *)getPreString:(NSString *)preString  postString:(NSString *)postString
{
    FreezeDetailCellModel *cellModel = [[FreezeDetailCellModel alloc]init];
    cellModel.preString = preString;
    if ([postString isEqualToString:@"-- --"]) {
        postString = @"--";
    }
    cellModel.postString = postString;
    return cellModel;
}



- (RoomDetailView *)mainView {
    if (!_mainView) {
        _mainView = [RoomDetailView loadViewFrom:@"RoomDetailView"];
    }
    return _mainView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
