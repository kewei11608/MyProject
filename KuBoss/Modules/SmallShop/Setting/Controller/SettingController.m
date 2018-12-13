//
//  SettingController.m
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"设置"];
    [self addLeftItem];
    [self.view addSubview:self.tbView];
    //测试Git 提交---哈哈哈哈哈哈哈哈哈
    //测试Git 第二次更新a哈   哈啦啦啦啦

}

#pragma mark - Delegate 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"微店简称";
        cell.detailTextLabel.text=@"北京天安门";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"地址";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
    }
    return _tbView;
}

- (void)addLeftItem
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 44, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_return_icon"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(-6,(44 - 30) / 2.0, 21, 30);
    arrow.backgroundColor = [UIColor clearColor];
    
    [left addSubview:arrow];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
}
- (void)backForePage
{
    self.backtabar();
}


@end
