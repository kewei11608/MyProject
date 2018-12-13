//
//  SmallShopController.m
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "SmallShopController.h"
#import "CardCycleScrollCell.h"
#import "SmallShopDataCell.h"

@interface SmallShopController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *baseTableView;

@end

@implementation SmallShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"微店简称"];
    [self.view addSubview:self.baseTableView];
    [self addLeftItem];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return MSW/690*320+10;
    }else if (indexPath.section==1){
        return 500;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellID = @"CardCycleScrollCell";
        CardCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CardCycleScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
        
    }else if (indexPath.section==1){
        static NSString *cellID = @"SmallShopDataCell";
        SmallShopDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SmallShopDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
        
    }
  
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    
}



-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MSW, MSXH-NAVH-49) style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _baseTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _baseTableView.tableFooterView = [[UIView alloc] init];
        AdjustsScrollViewInsetNever(self,_baseTableView);
        _baseTableView.estimatedRowHeight = 0;
        _baseTableView.estimatedSectionHeaderHeight = 0;
        _baseTableView.estimatedSectionFooterHeight = 0;
    }
    return _baseTableView;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
