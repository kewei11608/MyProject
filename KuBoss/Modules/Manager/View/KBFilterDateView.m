//
//  KBFilterDateView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFilterDateView.h"



@interface KBFilterDateView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *leftTbView;
@property (nonatomic,strong) UITableView *rightTbView;
@property (nonatomic,strong) NSMutableArray *dayArray;
@property (nonatomic,strong) NSMutableArray *weekArray;
@property (nonatomic,strong) NSMutableArray *monthArray;

@property (nonatomic,assign) KBDateMode  dateMode;
@property (nonatomic,assign) KBDateMode  lastDateMode;
@property (nonatomic,assign) NSInteger  lastLeftIndex;
@property (nonatomic,assign) NSInteger  lastRightIndex;
@end
@implementation KBFilterDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.dateMode = KBDateModeDay;
    self.dayArray = [[NSMutableArray alloc]init];
    self.weekArray = [[NSMutableArray alloc]init];
    self.monthArray = [[NSMutableArray alloc]init];
    self.lastDateMode = KBDateModeDay;
    self.dateMode = KBDateModeDay;
    self.lastRightIndex = [[KBUserDefaultLayer getRightFilterDate] integerValue];
    
    [self setup];
    return self;
}

- (void)setup
{
    UIView *bgView = [[UIView alloc]initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    [self addSubview:self.leftTbView];
    [self addSubview:self.rightTbView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    
    [bgView addGestureRecognizer:tap];
}

- (void)clickView
{
    self.hidden = YES;
    if (self.hideSelfBlock) {
        self.hideSelfBlock();
    }
}

- (UITableView *)rightTbView
{
    if (!_rightTbView) {
        _rightTbView = [[UITableView alloc]initWithFrame:CGRectMake(self.ct_width/2, 0, self.ct_width/2,180) style:UITableViewStylePlain];
        _rightTbView.delegate = self;
        _rightTbView.dataSource = self;
        _rightTbView.backgroundColor = KBCOLOR_WITH_HEX(0xF0F0F0);
        _rightTbView.tableFooterView = [UIView new];
        _rightTbView.scrollEnabled = NO;
        
    }
    
    return _rightTbView;
}

- (UITableView *)leftTbView
{
    if (!_leftTbView) {
        _leftTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width/2+1,180) style:UITableViewStylePlain];
        _leftTbView.delegate = self;
        _leftTbView.dataSource = self;
        _leftTbView.backgroundColor = [UIColor whiteColor];
        _leftTbView.tableFooterView = [UIView new];
        _leftTbView.scrollEnabled = NO;
        
    }
    
    return _leftTbView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (self.leftTbView == tableView) {
         cell.textLabel.textColor = KBCOLOR_WITH_HEX(0x666666);
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"昨日数据";
                break;
            case 1:
                 cell.textLabel.text = @"周数据";
                break;
            case 2:
                 cell.textLabel.text = @"月数据";
                break;
                
            default:
                break;
        }
        
        if (self.dateMode-1 == [[KBUserDefaultLayer getLeftFilterDate] integerValue])
        {

                if ([[KBUserDefaultLayer getLeftFilterDate] integerValue]== indexPath.row)
                {
                    cell.textLabel.textColor = kMainColor;
                   
                }
        }
        else
        {
            if (indexPath.row == 0) {
                cell.textLabel.textColor = kMainColor;
            }
        }
       
    }
    if (self.rightTbView == tableView) {
        cell.backgroundColor = KBCOLOR_WITH_HEX(0xF0F0F0);
        cell.textLabel.textColor = KBCOLOR_WITH_HEX(0x666666);
        switch (self.dateMode) {
            case KBDateModeDay:
                cell.textLabel.text =((KBFilterDayModel *)[self.dayArray objectAtIndex:indexPath.row]).data;
                if ([cell.textLabel.text isEqualToString:@"0"]) {
                    cell.textLabel.text = @"统计中";
                }
                break;
            case KBDateModeWeek:
                cell.textLabel.text = ((KBFilterWeekModel*)[self.weekArray objectAtIndex:indexPath.row]).data;
                break;
            case KBDateModeMonth:
                cell.textLabel.text = ((KBFilterMonthModel*)[self.monthArray objectAtIndex:indexPath.row]).data;
                break;

            default:
                break;
        }
        
        if (self.dateMode-1 == self.lastDateMode) {
            if ( self.lastRightIndex == indexPath.row) {
                cell.textLabel.textColor = kMainColor;
            }

        }
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rightTbView == tableView) {
        switch (self.dateMode) {
            case KBDateModeDay:
                return self.dayArray.count;
                break;
            case KBDateModeWeek:
                 return self.weekArray.count;
                break;
            case KBDateModeMonth:
                 return self.monthArray.count;
                break;
                
            default:
                break;
        }
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)changeTableView:(UITableView *)tbView indexPath:(NSIndexPath *)indexPath
{
    [tbView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.textLabel.textColor = KBCOLOR_WITH_HEX(0x666666);
    }];
    UITableViewCell *cell = [tbView cellForRowAtIndexPath:indexPath];
    if (cell) {
        cell.textLabel.textColor = kMainColor;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTbView)
    {
       
       
        if (indexPath.row == 0) {
            self.dateMode = KBDateModeDay;
        }
        else if (indexPath.row == 1) {
            self.dateMode = KBDateModeWeek;
        }
        else if (indexPath.row == 2) {
            self.dateMode = KBDateModeMonth;
        }
        [self.rightTbView reloadData];
        
        self.lastLeftIndex = indexPath.row;
        [self changeTableView:tableView indexPath:indexPath];
    }
    else if (tableView == self.rightTbView)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if ([cell.textLabel.text isEqualToString:@"统计中"]) {
//            return;
//        }
        [self changeTableView:tableView indexPath:indexPath];
        NSInteger type;
        NSString *data;
        switch (self.dateMode) {
            case KBDateModeDay:
            {
                type = ((KBFilterDayModel *)[self.dayArray objectAtIndex:indexPath.row]).type;
                data = ((KBFilterDayModel *)[self.dayArray objectAtIndex:indexPath.row]).data;
            }
               
                break;
            case KBDateModeWeek:
            {
                type = ((KBFilterWeekModel*)[self.weekArray objectAtIndex:indexPath.row]).type;
                data = ((KBFilterWeekModel*)[self.weekArray objectAtIndex:indexPath.row]).data;
            }
               
                break;
            case KBDateModeMonth:
            {
                type = ((KBFilterMonthModel*)[self.monthArray objectAtIndex:indexPath.row]).type;
                data = ((KBFilterMonthModel*)[self.monthArray objectAtIndex:indexPath.row]).data;
            }
               
                break;
                
            default:
                break;
        }
        self.lastDateMode = self.dateMode;
        self.lastRightIndex = indexPath.row;
        [KBUserDefaultLayer setRightFilterDate:[NSString stringWithFormat:@"%ld",indexPath.row]];
        [KBUserDefaultLayer setVauleFilterDate:data];
        [KBUserDefaultLayer setTypeFilterDate:[NSString stringWithFormat:@"%ld",type]];
        [KBUserDefaultLayer setLeftFilterDate:[NSString stringWithFormat:@"%ld", self.lastLeftIndex]];
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.filterDateBlock) {
                self.filterDateBlock(self.dateMode,type,data);
            }
            self.hidden = YES;
        });
   
    }
}

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel
{
    
    [self.dayArray removeAllObjects];
    [self.weekArray removeAllObjects];
    [self.monthArray removeAllObjects];
    [self.dayArray addObjectsFromArray:filterDateModel.data.day];
    [self.weekArray addObjectsFromArray:filterDateModel.data.week];
    [self.monthArray addObjectsFromArray:filterDateModel.data.month];
    
    if ([KBUserDefaultLayer getLeftFilterDate]) {
        self.dateMode = [[KBUserDefaultLayer getLeftFilterDate] integerValue];
        self.lastDateMode = self.dateMode;
    }
    else
    {
        self.lastDateMode = KBDateModeDay;
        self.dateMode = KBDateModeDay;
    }
    
    
    [self.leftTbView reloadData];
    
    if (![KBUserDefaultLayer getRightFilterDate]) {
        [KBUserDefaultLayer setRightFilterDate:@"0"];
    }
    self.lastRightIndex = [[KBUserDefaultLayer getRightFilterDate] integerValue];
    NSIndexPath * selIndex = [NSIndexPath indexPathForRow:self.dateMode inSection:0];
    if (![KBUserDefaultLayer getLeftFilterDate]) {
        selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [self tableView:self.leftTbView didSelectRowAtIndexPath:selIndex];
    

}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden: hidden];
    if (!hidden) {
        [self.leftTbView reloadData];
    }
}



@end
