//
//  KBSheetView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "RoomSheetView.h"
@interface RoomSheetView ()
@property (nonatomic,strong) NSMutableArray *list;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@end
@implementation RoomSheetView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tbView.separatorInset =UIEdgeInsetsZero;
    self.list = [[NSMutableArray alloc]init];
    [self.tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction {
    self.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.didSelectedBlock){
            self.didSelectedBlock(indexPath.row);
        }
        self.hidden = YES;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)setDataArray:(NSArray *)array
{
    [self.list removeAllObjects];
    [self.list addObjectsFromArray:array];
    if(self.list.count>=5 )
    {
        self.topConstraint.constant = self.ct_height - 250;
    }
    else
    {
        self.topConstraint.constant = self.ct_height - self.list.count *50;
    }
    [self.tbView reloadData];
}

@end
