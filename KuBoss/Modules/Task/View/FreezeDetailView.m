//
//  FreezeDetailView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/26.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "FreezeDetailView.h"
#import "FreezeDetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation  FreezeDetailCellModel

@end

@interface FreezeDetailView ()
@property (nonatomic,strong)NSMutableArray *list;

@end
@implementation FreezeDetailView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.list = [[NSMutableArray alloc]init];
    self.avatarImg.layer.cornerRadius = 25;
    self.avatarImg.layer.masksToBounds = YES;
    [self.tbView registerNib:[UINib nibWithNibName:@"FreezeDetailCell" bundle:nil]forCellReuseIdentifier:@"MyCell"];

    
}
- (IBAction)tellAction:(id)sender {
    if (self.iphone.length >0)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.iphone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    } else {
        [KBAlter show:@"暂无电话，请稍后再试" superView:[UIApplication sharedApplication].keyWindow];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 13) {
        return 58.5;
    } else {
        return 28.5;
    }
    
    return [tableView fd_heightForCellWithIdentifier:@"MyCell" cacheByIndexPath:indexPath configuration:^(FreezeDetailCell *cell) {
        cell.postLable.text = ((FreezeDetailCellModel*)[self.list objectAtIndex:indexPath.row]).postString;
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"MyCell";
    FreezeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"FreezeDetailCell" owner:self options:nil] lastObject];
//    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    FreezeDetailCellModel *model = [self.list objectAtIndex:indexPath.row];
    cell.preLable.text = model.preString;
    cell.postLable.text = model.postString;
    return cell;
}


- (void)setArray:(NSArray *)array
{
    [self.list removeAllObjects];
    [self.list addObjectsFromArray:array];
    [self.tbView reloadData];
}
    

- (IBAction)freezeAction:(id)sender {
    if (self.freezeBlock) {
        self.freezeBlock();
    }
}
- (IBAction)leaveOfficeActiom:(id)sender {
    if (self.leaveBlock) {
        self.leaveBlock();
    }
}



@end
