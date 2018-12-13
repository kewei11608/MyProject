//
//  KBShopFilterView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShopFilterView.h"

@interface KBShopFilterView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic, strong) UIView *tapView;
@end
@implementation KBShopFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.array = [[NSMutableArray alloc]init];
    [self setup];
    return self;
}

- (void)setup
{
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor  = [UIColor blackColor];
    bgView.alpha  = 0.8;
    [self addSubview:bgView];
    [self addSubview:self.tbView];
  
    self.tapView = [[UIView alloc] init];
    [self addSubview:self.tapView];
    [self.tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.tbView.mas_bottom);
    }];
    [self.tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction {
    self.hidden = YES;
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    KBGgmdimModel *model = [self.array objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (model.isSame) {
        cell.textLabel.textColor = kMainColor;
    }else{
        cell.textLabel.textColor = KBCOLOR_WITH_HEX(0x666666);
    }

 
    cell.textLabel.text = model.officename;
    cell.textLabel.font = [UIFont  systemFontOfSize:14];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
 
    
    NSArray *array = [tableView visibleCells];
    [array enumerateObjectsUsingBlock:^( UITableViewCell *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.textLabel.textColor = KBCOLOR_WITH_HEX(0x666666);
    }];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kMainColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        KBGgmdimModel *model = [self.array objectAtIndex:indexPath.row];
        model.isSame = YES;
        
        if (self.filterShopBlock) {
            self.filterShopBlock(model.officeid,model.officename);
        }
        self.hidden = YES;
    });
 
    
}


- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 50*5) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView  = [UIView new];
        _tbView.scrollEnabled = NO;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tbView.separatorInset =UIEdgeInsetsZero;
        
    }
    
    return _tbView;
}

- (void)setShopList:(NSArray *)array
{
    [self.array  removeAllObjects];
    [self.array addObjectsFromArray:array];
    [self.tbView reloadData];
    self.tbView.frame = CGRectMake(0, 0, self.ct_width, self.array.count*45);
}



@end
