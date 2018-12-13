//
//  HousingDetailsController.m
//  CoolBroker
//
//  Created by lidan on 2018/9/14.
//  Copyright © 2018年 bxs. All rights reserved.
//

#import "HousingDetailsController.h"
#import "HousingTopCell.h"
#import "HousingMsgCell.h"



@interface HousingDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString        *_encounterDateCount;      //带看记录7天的总数
    NSString        *_encounterNineDateCount;  //带看记录90天的总数
    NSString        *_followUpDateCount;       //跟进记录7天的总数
    NSString        *_followUpNineDateCount;   //跟进记录90的总数
    NSMutableArray  *_loopArray;               //轮播
    NSMutableArray  *_loopimageArray;          //轮播图片
    NSMutableArray  *_contactsArray;          //房源联系人
    UIButton        *_btedit;                 //编辑按钮
    int             _isfirst;
}
@property (nonatomic, strong) UITableView           *baseTableView;


@end

@implementation HousingDetailsController
-(instancetype)init{
    self = [super init];
    if (self) {
      
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseTableView];
    [self setCustomTitle:@"远洋公馆"];

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
    }else if (section==2){
        return 1;
    }else if (section==3){
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return MSW/750*562;
    }else if (indexPath.section==1){
    return 500;
    }
    
    return 0.0001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {   //轮播
        static NSString *cellID = @"HousingTopCell";
        HousingTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HousingTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
      
        
        

        
        return cell;
    }else if (indexPath.section==1){
        static NSString *cellID = @"HousingMsgCell";
        HousingMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HousingMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        

        return cell;
    }
    
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark 点击查看地址
-(void)clicktoviewaddress{

    
}




-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MSW, MSXH-70) style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _baseTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _baseTableView.tableFooterView = [[UIView alloc] init];
        AdjustsScrollViewInsetNever(self,_baseTableView);
        _baseTableView.estimatedRowHeight = 0;
        _baseTableView.estimatedSectionHeaderHeight = 0;
        _baseTableView.estimatedSectionFooterHeight = 0;
    }
    return _baseTableView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
