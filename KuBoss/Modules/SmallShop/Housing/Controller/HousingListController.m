//
//  HousingListController.m
//  KuBoss
//
//  Created by lidan on 2018/11/21.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "HousingListController.h"
#import "HousingListCell.h"
#import "HousingDetailsController.h"
#import "HelpView.h"
#import "DropSelectView.h"

@interface HousingListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *headview;
@property (nonatomic, strong) UITableView           *baseTableView;
@property (nonatomic, strong) DropSelectView        *selectView;

@end

@implementation HousingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    [self createSegMentController];
    [self.view addSubview:self.headview];
    [self.view addSubview:self.baseTableView];
    [self.view addSubview:self.selectView];
    [self addLeftItem];
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
-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"二手房",@"租赁",nil];
    
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
        
    }else{
        
        
    }
    
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
  
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 314/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *cellID = @"HousingListCell";
        HousingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HousingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
            return cell;
 
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HousingDetailsController * coolVC = [[HousingDetailsController alloc]init];
    coolVC.hidesBottomBarWhenPushed = YES;
   
    [self.navigationController pushViewController:coolVC animated:YES];
}
    
-(void)buttonclick:(UIButton*)sender{
    if (sender.tag==0) {
        [HelpView showWithdata:@{} action:^(NSInteger index) {
            
        }];
        
    }else if (sender.tag==1){
        [_selectView showView];
        sender.selected=!sender.selected;
    }
    
    
}
-(UIView *)headview{
    if (!_headview) {
        _headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 59)];
        _headview.backgroundColor=[UIColor whiteColor];
        UIView*grayview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 24)];
        grayview.backgroundColor=RGBCOLOR(244, 245, 250);
        
        UIButton*bthelp = [UIButton buttonWithType:UIButtonTypeCustom];
        bthelp.frame = CGRectMake(grayview.width-90, 0,70, grayview.height);
        [bthelp setTitle:@"帮助" forState:0];
        bthelp.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bthelp setImage:[UIImage imageNamed:@"house_help"] forState:UIControlStateNormal];
        bthelp.titleLabel.font=[UIFont systemFontOfSize:12];
        [bthelp addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [bthelp setTitleColor:[UIColor grayColor] forState:0];
        bthelp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        bthelp.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bthelp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [grayview addSubview:bthelp];
        bthelp.tag=0;
        [_headview addSubview:grayview];
        
        
        UIButton*btall = [UIButton buttonWithType:UIButtonTypeCustom];
        btall.frame = CGRectMake(20, grayview.bottom, 80,35);
        [btall setTitle:@"全部房源" forState:0];
        btall.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btall setImage:[UIImage imageNamed:@"down_arrow_dark"] forState:UIControlStateNormal];
        [btall setImage:[UIImage imageNamed:@"down_arrow_light"] forState:UIControlStateSelected];
        btall.titleLabel.font=[UIFont systemFontOfSize:12];
        [btall addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [btall setTitleColor:RGBCOLOR(74, 74, 74) forState:0];
        [_headview addSubview:btall];
        btall.tag=1;

//        btall.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        CGFloat imageWidth = btall.imageView.bounds.size.width;
        CGFloat labelWidth = btall.titleLabel.bounds.size.width;
        btall.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
        btall.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-10, 0, imageWidth);
        UIButton*btbrowse = [UIButton buttonWithType:UIButtonTypeCustom];
        btbrowse.frame = CGRectMake(_headview.width-100, grayview.bottom, 80,35);
        [btbrowse setTitle:@"总浏览量  " forState:0];
        btbrowse.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btbrowse setImage:[UIImage imageNamed:@"house_browse1"] forState:UIControlStateNormal];
        [btbrowse setImage:[UIImage imageNamed:@"house_browse2"] forState:UIControlStateSelected];
        btbrowse.titleLabel.font=[UIFont systemFontOfSize:12];
        [btbrowse addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [btbrowse setTitleColor:RGBCOLOR(74, 74, 74) forState:0];
        [_headview addSubview:btbrowse];
        CGFloat imageWidth2 = btbrowse.imageView.bounds.size.width;
        CGFloat labelWidth2 = btbrowse.titleLabel.bounds.size.width;
        btbrowse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btbrowse.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth2-10, 0, -labelWidth2);
        btbrowse.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth2-10, 0, imageWidth2);
        btbrowse.tag=2;
        
    }
    return _headview;
}
-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headview.bottom, MSW, MSXH-NAVH-_headview.height-49) style:UITableViewStylePlain];
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
-(DropSelectView *)selectView{
    if (!_selectView) {
        _selectView=[[DropSelectView alloc]initWithFrame:CGRectMake(0, _baseTableView.top, MSW, MSXH) anddata:@[@"全部房源",@"本地房源"]];
        _selectView.hidden=YES;
        _selectView.TextFont=[UIFont systemFontOfSize:12];
        _selectView.normalColor=RGBCOLOR(74, 74, 74);
        _selectView.selectColor=kMainColor;
        _selectView.hiddenFilterview = ^{

        };
        _selectView.dropselectindex = ^(int index) {
            DLog(@"dfghi---%i",index);
        };
    }
    return _selectView;
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
