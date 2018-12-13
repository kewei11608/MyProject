//
//  KBBusinessManagerView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBusinessManagerView.h"
#import "KBSeletedControl.h"
#import "KBBusinessManageCell.h"
#import "KBBusinessManagerHeadView.h"
#import "KBUpdateFootView.h"
#import "KBFilterDateView.h"
@interface KBBusinessManagerView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBBusinessManagerHeadView *headView;
@property (nonatomic,strong)KBUpdateFootView *footView;
@property (nonatomic,strong)KBFilterDateView *filterView;
@property (nonatomic,strong)NSMutableArray *list;
@property (nonatomic,strong)UIButton *dateBtn;
@property (nonatomic,assign)BOOL isNew;
@property (nonatomic, strong) KBSeletedControl *seletedControl;

@end
@implementation KBBusinessManagerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.list = [[NSMutableArray alloc]init];
    self.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self setup];
    return self;
}

- (void)setup
{
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        
        if ([[KBUserDefaultLayer getFilterHouseType] integerValue] - 100 == 2) {
            self.isNew = YES;
        };
    }
    KBSeletedControl *seletedControl = [[KBSeletedControl alloc] initWithFrame:CGRectMake(0, 0, self.ct_width, 50) titleArray:@[@"二手房",@"租赁",@"新房"]];
    seletedControl.backgroundColor = [UIColor whiteColor];
    [self addSubview:seletedControl];
    self.seletedControl = seletedControl;
     @KBWeakObj(self);
    seletedControl.selectedIndexBlock = ^(UIButton *btn) {
         @KBStrongObj(self);
        if (self.filterHousingBlock) {
            self.filterHousingBlock(btn.tag  - 100);
        }
        if (btn.tag-100 == 2) {
            self.headView.isNew = YES;
            self.isNew = YES;
        }
        else{
            self.headView.isNew = NO;
            self.isNew = NO;
        }
       
    };
    
    
    self.dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dateBtn.frame = CGRectMake(self.ct_width -self.ct_width/2 , 0, self.ct_width/2, 50);
    self.dateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
    [self.dateBtn addTarget:self action:@selector(seletedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dateBtn];
    
    [self addSubview:self.tbView];
    
    [self addSubview:self.filterView];
    self.filterView.hidden = YES;
    self.filterView.filterDateBlock = ^(KBDateMode mode,NSInteger type,NSString *data) {
        @KBStrongObj(self);
        NSString *tilteString = [NSString stringWithFormat:@"%@ %@",data,[self getDateModeString:mode]];
         [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:tilteString] forState:UIControlStateNormal];
        
        if (self.filterDateBlock) {
            self.filterDateBlock(mode,type);
        }
    };
    
    self.filterView.hideSelfBlock = ^{
         @KBStrongObj(self);
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
    };
    
    [self addSubview:self.footView];
    
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


- (void)click
{
    
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBBusinessManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBBusinessManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:[self.list objectAtIndex:indexPath.row] isNew:self.isNew];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KBListRBModel *model = [self.list objectAtIndex:indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}


- (UITableView *)tbView
{
    if (!_tbView) {
        
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.ct_width, self.ct_height-60) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.headView;
//        _tbView.tableFooterView = self.footView;
        _tbView.tableFooterView = [UIView new];
        
    }
    
    return _tbView;
}

- (KBBusinessManagerHeadView *)headView
{
    if (!_headView) {
        _headView = [[KBBusinessManagerHeadView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 275)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_headView addGestureRecognizer:tap];
        
        
    }
    return _headView;
}

- (KBUpdateFootView *)footView
{
    if (!_footView) {
        _footView = [[KBUpdateFootView alloc]initWithFrame:CGRectMake(0, self.ct_height - 40, self.ct_width, 40)];
    }
    return _footView;
}

- (KBFilterDateView *)filterView
{
    if (!_filterView) {
        _filterView = [[KBFilterDateView alloc]initWithFrame:CGRectMake(0, 60, self.ct_width, self.ct_height-60)];
    }
    return _filterView;
}

- (void)setBusinessModel:(KBRBHomeModel *)model
{
    NSArray *array = model.data.zrzsj;
    if (array.count>0) {
        self.headView.hidden = NO;
       [self.headView setModel:array.firstObject];
    }
    else
    {
        self.headView.hidden = NO;
        [self.headView setModel:nil];
    }
    [self.footView setTitle:model.data.gxsj];
    [self.list removeAllObjects];
    [self.list addObjectsFromArray:model.data.ggmdlist];
    [self.tbView reloadData];
    if (self.list.count != 0) {
       // self.tbView.tableFooterView = self.footView;
        self.footView.hidden = NO;
    }
    else{
        self.footView.hidden = NO;

//          self.footView.hidden = YES;
    }
}

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel
{
    [self.filterView setFilterDataModel:filterDateModel];
}

- (void)reload {
    [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
    if ([KBUserDefaultLayer getFilterHouseType]) {
        [self.seletedControl setSelectedIndex:[[KBUserDefaultLayer getFilterHouseType] integerValue] - 100];
    }
}

@end
