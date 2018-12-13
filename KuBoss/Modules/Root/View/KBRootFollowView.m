//
//  KBRootFollowView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootFollowView.h"
#import "KBFollowCollectionViewCell.h"
#import "KBHeader.h"
@interface KBRootFollowView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *list;

@end
@implementation KBRootFollowView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)  return nil;
    self.backgroundColor = [UIColor whiteColor];
    self.list = [[NSMutableArray alloc]init];
    [self setup];
    return self;
}

- (void)setFollowArray:(NSArray *)array
{
    [self.list removeAllObjects];
    [self.list addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (void)setup
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [self addSubview:leftView];
    
    UILabel *followLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 15, 200, 16)];
    followLable.text  = @"关注指标";
    followLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:followLable];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, leftView.ct_bottom+15, self.ct_width-15, 1)];
    line.backgroundColor = KBCOLOR_WITH_HEX(0xE2E2E2);
    [self addSubview:line];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,followLable.ct_bottom+31, self.frame.size.width, 100) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    [self.collectionView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    [self  addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerClass:[KBFollowCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.list.count <=3)
        return self.list.count;
    return 3;
    
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    KBFollowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.isFollowed = YES;
    KBBottomIndicatorConcernModel * model = [self.list objectAtIndex:indexPath.row];
    [cell setModel:model];
    [cell home];
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_WIDTH < 375) {
        return CGSizeMake(92, 90);
    }
    return  CGSizeMake(110,100);
}



#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);//（上、左、下、右）
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 7;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)tapAction {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




@end
