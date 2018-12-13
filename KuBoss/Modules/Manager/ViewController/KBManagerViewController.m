//
//  KBManagerViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerViewController.h"
#import "KBResourceManagerView.h"
#import "KBBusinessManagerView.h"
#import "KBManagerShopViewController.h"
#import "KBRootViewController.h"

@interface KBManagerViewController ()
@property (nonatomic,strong)KBResourceManagerView *resourceManagerView;
@property (nonatomic,strong)KBBusinessManagerView *businessManagerView;

@property (nonatomic,assign) KBDateMode  dataMode;
@property (nonatomic,assign) NSInteger   dataRange;
@property (nonatomic,assign) NSInteger   housingType;

@end

@implementation KBManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  whiteColor];
    [self createSegMentController];
    
   
    
    
    [self.view addSubview:self.businessManagerView];
    [self.view addSubview:self.resourceManagerView];
    self.businessManagerView.hidden = NO;
    self.resourceManagerView.hidden = YES;
    
    
    
    
    @KBWeakObj(self);
    self.businessManagerView.selectedBlock = ^(KBListRBModel *shopListModel) {
        @KBStrongObj(self);
        [KBUserBehavior  behaviorEventId:KBClickStoreListEventId];
        KBManagerShopViewController *shop = [[KBManagerShopViewController alloc]initShopId:shopListModel.officeid shopName:shopListModel.officename];
        [self.navigationController pushViewController:shop animated:YES];
    };
    self.businessManagerView.filterDateBlock = ^(KBDateMode mode,NSInteger type) {
         @KBStrongObj(self);
        if (KBDateModeDay == mode)
        {
            [KBUserBehavior  behaviorEventId:KBBusinessYesterdaysDataEventId];
        }
        else if (KBDateModeWeek == mode)
        {
            [KBUserBehavior  behaviorEventId:KBBusinessWeeklyDataEventId];
        }
        else if (KBDateModeMonth == mode)
        {
             [KBUserBehavior  behaviorEventId:KBBusinessMonthlyDataEventId];
        }
        self.dataMode = mode;
        self.dataRange = type;
        [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
    };
    
    self.businessManagerView.filterHousingBlock = ^(NSInteger housingType) {
        @KBStrongObj(self);
        self.housingType = housingType;
        [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
        
    };
    

    self.resourceManagerView.filterShopBlock = ^(NSString *shopId) {
        @KBStrongObj(self);
        if ([shopId isEqualToString:@"0"]) {
             [KBUserBehavior  behaviorEventId:KBSummaryDataEventId];
        }
        else
        {
            [KBUserBehavior  behaviorEventId:KBIndividualStoreDataEventId];
        }
      
        [self resourceApi:shopId];
   
    };
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior  behaviorEventId:KBBusinessManagerSummaryEventId];
    
    self.dataMode = KBDateModeDay;
    self.dataRange = 1;
    self.housingType = 0;
    
    if ([KBUserDefaultLayer getLeftFilterDate])
    {
        self.dataMode = [[KBUserDefaultLayer getLeftFilterDate] integerValue] +1;
    };
    
    
    if ([KBUserDefaultLayer getTypeFilterDate]) {
        self.dataRange =  [[KBUserDefaultLayer getTypeFilterDate] integerValue];
    };
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        self.housingType = [[KBUserDefaultLayer getFilterHouseType] integerValue] - 100;
    }
    [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
    [self filteData];
    [self resourceApi:@"0"];
    [self.businessManagerView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 self.dataMode = KBDateModeDay;
 self.dataRange = 1;
 self.housingType = 0;
 
 self.view.backgroundColor = [UIColor  whiteColor];
 [self createSegMentController];
 
 if ([KBUserDefaultLayer getLeftFilterDate])
 {
 self.dataMode = [[KBUserDefaultLayer getLeftFilterDate] integerValue] +1;
 };
 
 
 if ([KBUserDefaultLayer getTypeFilterDate]) {
 self.dataRange =  [[KBUserDefaultLayer getTypeFilterDate] integerValue];
 };
 
 if ([KBUserDefaultLayer getFilterHouseType]) {
 self.housingType = [[KBUserDefaultLayer getFilterHouseType] integerValue] - 100;
 }
 
 self.businessManagerView = nil;
 self.resourceManagerView = nil;
 
 [self.view addSubview:self.businessManagerView];
 [self.view addSubview:self.resourceManagerView];
 self.businessManagerView.hidden = NO;
 self.resourceManagerView.hidden = YES;
 
 
 [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
 [self filteData];
 [self resourceApi:@"0"];
 
 @KBWeakObj(self);
 self.businessManagerView.selectedBlock = ^(KBListRBModel *shopListModel) {
 @KBStrongObj(self);
 [KBUserBehavior  behaviorEventId:KBClickStoreListEventId];
 KBManagerShopViewController *shop = [[KBManagerShopViewController alloc]initShopId:shopListModel.officeid shopName:shopListModel.officename];
 [self.navigationController pushViewController:shop animated:YES];
 };
 self.businessManagerView.filterDateBlock = ^(KBDateMode mode,NSInteger type) {
 @KBStrongObj(self);
 if (KBDateModeDay == mode)
 {
 [KBUserBehavior  behaviorEventId:KBBusinessYesterdaysDataEventId];
 }
 else if (KBDateModeWeek == mode)
 {
 [KBUserBehavior  behaviorEventId:KBBusinessWeeklyDataEventId];
 }
 else if (KBDateModeMonth == mode)
 {
 [KBUserBehavior  behaviorEventId:KBBusinessMonthlyDataEventId];
 }
 self.dataMode = mode;
 self.dataRange = type;
 [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
 };
 
 self.businessManagerView.filterHousingBlock = ^(NSInteger housingType) {
 @KBStrongObj(self);
 self.housingType = housingType;
 [self buisness:self.dataMode dataRange:self.dataRange housingType:self.housingType];
 
 };
 
 
 self.resourceManagerView.filterShopBlock = ^(NSString *shopId) {
 @KBStrongObj(self);
 if ([shopId isEqualToString:@"0"]) {
 [KBUserBehavior  behaviorEventId:KBSummaryDataEventId];
 }
 else
 {
 [KBUserBehavior  behaviorEventId:KBIndividualStoreDataEventId];
 }
 
 [self resourceApi:shopId];
 
 };
 */

-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"业务管理",@"资源管理",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(0, 0, 180, 35);
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kMainColor;
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:segmentedControl];
}

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    NSInteger selecIndex = sender.selectedSegmentIndex;
    if (selecIndex == 0)
    {
//        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeBusinessManage])
//        {
            self.businessManagerView.hidden = NO;
            self.resourceManagerView.hidden = YES;
            [KBUserBehavior  behaviorEventId:KBEnterBusinessEventId];
//        }
    }
    else
    {
//        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeResourceManage]){
            self.businessManagerView.hidden = YES;
            self.resourceManagerView.hidden = NO;
            [KBUserBehavior  behaviorEventId:KBEnterResourceEventId];
//        }
    }
}
#pragma mark net
- (void)filteData
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]   filterDateSuccess:^(KBFilterDateModel * filterModel) {
         @KBStrongObj(self);
        NSLog(@"-=-=-=%@",filterModel);
        [KBAlter hideLoadingForView:self.view];
        [self.businessManagerView setFilterDataModel:filterModel];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];

    }];
    
}

- (void)resourceApi:(NSString *)shopId
{
     @KBWeakObj(self);
     [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] resourceWithOfficeid:shopId success:^(KBResourceManagerModel * model) {
        @KBStrongObj(self);
        [self.resourceManagerView setModel:model];
         [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
         [KBAlter hideLoadingForView:self.view];
    }];
}



- (void)buisness:(KBDateMode)mode dataRange:(NSInteger)dataRange housingType:(NSInteger)housingType
{
    @KBWeakObj(self);
     [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] resourceManagerHomeTimeType:mode dataRange:dataRange housingType:housingType success:^(KBRBHomeModel * model) {
        @KBStrongObj(self);
        [self.businessManagerView setBusinessModel:model];
         [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
         [KBAlter hideLoadingForView:self.view];
    }];
    
}




- (KBBusinessManagerView *)businessManagerView
{
    if (!_businessManagerView) {
        _businessManagerView = [[KBBusinessManagerView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    }
    return _businessManagerView;
}


- (KBResourceManagerView *)resourceManagerView
{
    if (!_resourceManagerView) {
        _resourceManagerView = [[KBResourceManagerView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    }
    return _resourceManagerView;
}




@end
