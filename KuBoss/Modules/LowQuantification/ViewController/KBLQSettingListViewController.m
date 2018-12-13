//
//  KBLQConfigListViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQSettingListViewController.h"
#import "KBLQSettingViewController.h"

@interface KBLQSettingListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSArray *list;
@property (nonatomic,strong)KBLQConfigModel * weekConfigmodel;
@property (nonatomic,strong)KBLQConfigModel * monthConfigmodel;
@end

@implementation KBLQSettingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"预警设置"];
    self.list = @[
                 @{@"title":@"每周低量化预警"
                    },
                  @{@"title":@"每月低量化预警"
                    }
                  ];
    [self.view addSubview:self.tbView];
    
    [self loadConfig];
    
}

- (void)loadConfig
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] lqConfigSuccess:^(KBLQUserConfigModel * model) {
        @KBStrongObj(self);
        [KBAlter hideLoadingForView:self.view];
        [model.data.dlhbz enumerateObjectsUsingBlock:^(KBLQConfigModel * configModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([configModel.lowquantificationtype integerValue] == 0) {
                self.weekConfigmodel = configModel;
            }
            else  if ([configModel.lowquantificationtype integerValue] == 1){
                 self.monthConfigmodel = configModel;
            }
            
        }];
        [self.tbView reloadData];
        
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;//添加箭头
//    cell.textLabel.text = [((NSDictionary *)[self.list objectAtIndex:indexPath.row]) objectForKey:@"title"];
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 15)];
    titleLable.text = [((NSDictionary *)[self.list objectAtIndex:indexPath.row]) objectForKey:@"title"];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    [cell addSubview:titleLable];
    
    
    UILabel *subtitleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLable.ct_bottom+10, 200, 15)];
//    subtitleLable.text = [((NSDictionary *)[self.list objectAtIndex:indexPath.row]) objectForKey:@"title"];
    subtitleLable.font = [UIFont systemFontOfSize:14];
    subtitleLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    [cell addSubview:subtitleLable];
    
    if (self.weekConfigmodel&&indexPath.row == 0) {
        subtitleLable.text = [NSString stringWithFormat:@"%@房 %@客 %@带 %@勘",self.weekConfigmodel.availabilitynumber,self.weekConfigmodel.touristnumber,self.weekConfigmodel.takealookinumber,self.weekConfigmodel.realservicenumber];

    }
    else if (self.monthConfigmodel&&indexPath.row == 1)
    {
        subtitleLable.text = [NSString stringWithFormat:@"%@房 %@客 %@带 %@勘",self.monthConfigmodel.availabilitynumber,self.monthConfigmodel.touristnumber,self.monthConfigmodel.takealookinumber,self.monthConfigmodel.realservicenumber];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBLQSettingViewController *vc;
    if(indexPath.row == 0)
    {
        vc = [[KBLQSettingViewController alloc]initWithBool:YES];
    }
    else{
        vc = [[KBLQSettingViewController alloc]initWithBool:NO];
    }
    [self.navigationController pushViewController:vc animated:YES];
   
}


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        //_tbView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tbView.tableFooterView = [UIView new];
    }
    
    return _tbView;
    
}

@end
