//
//  RoomDetailView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "RoomDetailView.h"
#import "FreezeDetailCell.h"

@interface RoomDetailView ()
@property (nonatomic,strong)NSMutableArray *list;
@end
@implementation RoomDetailView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.list = [[NSMutableArray alloc]init];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"FreezeDetailCell";
    FreezeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FreezeDetailCell" owner:self options:nil] lastObject];
    }
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


@end
