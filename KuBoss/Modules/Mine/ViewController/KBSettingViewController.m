//
//  KBSettingViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSettingViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "KBGlobalControllerCenter.h"
@interface KBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,assign) BOOL  isLeave;
@property (nonatomic,assign) BOOL  isFirst;

@end

@implementation KBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"设置"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    self.isLeave = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)navigationShouldPopOnBackButton
{
    if (self.isFirst) {
        if (!self.isLeave) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isLeave = YES;
            });
            return NO;
        }
        
    }
    
    [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeSetting];
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isLeave = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isLeave = YES;
    self.isFirst = YES;
}


#pragma mark - Delegate 代理


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
          cell.textLabel.text = @"修改手机号";
        
        if ([KBUserInfoModel iphone].length  >= 11) {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.ct_width-100-10, 13, 100, 20)];
            lable.text =  [[KBUserInfoModel iphone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            lable.font = [UIFont systemFontOfSize:13];
            lable.textColor = KBCOLOR_WITH_HEX(0x999999);
            [cell addSubview:lable];
        }
      
        
    }
    else if (indexPath.row == 1)
    {
          cell.textLabel.text = @"修改密码";
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
    if (indexPath.row == 0) {
         [self.navigationController pushViewController:[NSClassFromString(@"KBModifyIphoneViewController") new] animated:YES];
    }
    else if (indexPath.row == 1)
    {
          [self.navigationController pushViewController:[NSClassFromString(@"KBModifyPasswordViewController") new] animated:YES];
    }
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



@end
