//
//  KBMessageViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBMessageViewController.h"
#import "WZLBadgeImport.h"
#import "KBRootViewController.h"

@interface KBMessageViewModel:NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger nums;


@end
@implementation KBMessageViewModel

@end

@interface KBMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)KBMessageViewModel *firstModel;
@property (nonatomic,strong)KBMessageViewModel *secondModel;
@property (nonatomic,strong)KBMessageViewModel *threeModel;
@end

@implementation KBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"消息中心"];
    self.firstModel = [[KBMessageViewModel alloc]init];
    self.firstModel.icon = @"public_message";
    self.firstModel.title = @"业务通知";
    self.firstModel.nums = 0;
    
    self.secondModel = [[KBMessageViewModel alloc]init];
    self.secondModel.icon = @"station_message";
    self.secondModel.title = @"站内消息";
    self.secondModel.nums = 0;
    
    self.threeModel = [[KBMessageViewModel alloc]init];
    self.threeModel.icon = @"system_message";
    self.threeModel.title = @"系统公告";
    self.threeModel.nums = 0;

  
    self.arr = @[self.firstModel,self.secondModel,self.threeModel];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMessageModulesReadNumber];
    [self getMessageNoReadNumber];
}

- (void)getMessageNoReadNumber
{
    [[KBApiLayer sharedInstance]  messageAreaCode:1 success:^(KBMessgeUnreadModel * model) {
        [model.data enumerateObjectsUsingBlock:^(KBMessgeUnreadData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            if (obj.mstype == 1) {
                self.secondModel.nums = obj.count;
            }
            else if (obj.mstype == 0) {
                self.threeModel.nums = obj.count;
            }
        }];
         [self.tbView reloadData];
   
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)getMessageModulesReadNumber
{

    [[KBApiLayer sharedInstance]  messageModuleSuccess:^(KBBaseModel * model) {
        self.firstModel.nums = [model.data integerValue];
        [self.tbView reloadData];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KBMessageViewModel *model = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.image = [UIImage imageNamed:model.icon];
    [cell.imageView  kbShowBadgeWithStyle:WBadgeStyleNumber value:model.nums animationType:WBadgeAnimTypeNone];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeBusinessMessage]){
             [self.navigationController pushViewController:[NSClassFromString(@"KBModulesMessageViewController") new] animated:YES];
        }
       
    }
    else if (indexPath.row == 1)
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeSiteMessage]){
            [self.navigationController pushViewController:[NSClassFromString(@"KBStationMessageViewController") new] animated:YES];
        }
       
    }
    else if (indexPath.row == 2)
    {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeSystemMessage]){
            [self.navigationController pushViewController:[NSClassFromString(@"KBSystemMessageViewController") new] animated:YES];
        }
       
    }
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
     
    }
    
    return _tbView;
    
}





@end
