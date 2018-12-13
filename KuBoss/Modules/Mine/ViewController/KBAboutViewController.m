//
//  KBAboutViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAboutViewController.h"
#import "KBGlobalControllerCenter.h"
#import "UIViewController+BackButtonHandler.h"

@interface KBAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;

@end

@implementation KBAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"关于我们"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    // Do any additional setup after loading the view.
}

- (BOOL)navigationShouldPopOnBackButton
{
    
    [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeSetting];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"版本号 ： V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    else
    {
        cell.textLabel.text  = @"版本：最新版本";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = [self headView];
    }
    return _tbView;
}

- (UIView  *)headView
{
    UIView  *headView = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 254)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView  alloc]initWithImage:[UIImage  imageNamed:@"kuboss"]];
    logo.frame = CGRectMake((self.view.ct_width-84)/2, 80, 84, 84);
    [headView addSubview:logo];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, logo.ct_bottom+15, self.view.ct_width, 20)];
    lable.text =  @"酷boss版";
    lable.textColor = KBCOLOR_WITH_HEX(0x333333);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont  systemFontOfSize:18];
    [headView addSubview:lable];
    
    
    return headView;
}


@end
