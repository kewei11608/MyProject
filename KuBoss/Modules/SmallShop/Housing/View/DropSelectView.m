//
//  DropSelectView.m
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "DropSelectView.h"
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//#define VIEWHEIGHT            400
//#define CELLHEIGHT            44

@interface DropSelectView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton      *_bgbutton;
    UIView         *_whiteview;
    NSInteger      _selectindex;
    
    int           _viewheight;
    int           _cellheight;

}
@property (nonatomic ,strong) UITableView * firsttableView;

@end


@implementation DropSelectView
-(id)initWithFrame:(CGRect)frame anddata:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _cellheight=44;
        _dataarray=array;
        _viewheight=(int)_dataarray.count*_cellheight;
        _selectindex=9999999;

        [self createUI];
    }
    return self;
    
}
#pragma mark - 创建视图
- (void)createUI
{
    self.clipsToBounds=YES;
    _bgbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, MSXH-NAVH-40)];
    _bgbutton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3] ;
    [self addSubview:_bgbutton];
    [_bgbutton addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    
    _whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, -_viewheight, MSW, _viewheight)];
    _whiteview.backgroundColor=[UIColor whiteColor];
    [_bgbutton addSubview:_whiteview];
    
    
    self.firsttableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _whiteview.width, _whiteview.height)];
    self.firsttableView.delegate = self;
    self.firsttableView.dataSource = self;
    self.firsttableView.estimatedSectionHeaderHeight = 0;
    self.firsttableView.estimatedSectionFooterHeight = 0;
    self.firsttableView.estimatedRowHeight = 0;
    self.firsttableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_whiteview addSubview: self.firsttableView];
    
    
    
}

#pragma mark - UITableViewDataSource&&Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellheight;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  _dataarray.count;
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *identifier = @"lefCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            tableView.separatorStyle = UITableViewCellSelectionStyleNone;
            UILabel*lbline = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, _firsttableView.width, 0.5)];
            lbline.backgroundColor = [UIColor colorWithHex:@"#e6e6e6"];
            [cell addSubview:lbline];
            
        }
     
    cell.textLabel.text=[_dataarray objectAtIndex:indexPath.row];
    cell.textLabel.font=_TextFont;
    if (indexPath.row==_selectindex) {
        cell.textLabel.textColor=_selectColor;
    }else{
        cell.textLabel.textColor=_normalColor;
    }
        return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectindex=indexPath.row;
    [_firsttableView reloadData];
    self.dropselectindex((int)indexPath.row);
    [self hiddenView];
}

-(void)showView
{
    self.hidden=NO;
    self.alpha=1;
    [UIView animateWithDuration:0.3f animations:^{
        _whiteview.frame = CGRectMake(0, 0,MSW, _viewheight);
    }completion:^(BOOL finished) {
        
    }];
}
/**
 *  隐藏
 */
-(void)hiddenView
{

    self.hiddenFilterview();
    [UIView animateWithDuration:0.3f animations:^{
        
        _whiteview.frame = CGRectMake(0, -_viewheight,MSW, _viewheight);
        self.alpha=0;
    } completion:^(BOOL finished) {
        self.hidden=YES;
        
    }];
}



@end
