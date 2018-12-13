//
//  KBFollowViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFollowViewController.h"
#import "KBFollowCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "UIViewController+BackButtonHandler.h"
#import "KBBaseRequest.h"
#import "KBRequestManager.h"

@interface KBFollowViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *list;
@property (nonatomic,strong)NSMutableArray *followedlist;

@property (nonatomic, strong) NSMutableArray *selectedIndex;

@end

@implementation KBFollowViewController

- (instancetype)initFollowedArray:(NSArray *)array
{
    self = [super init];
    if (!self) return nil;
    self.array = [[NSMutableArray alloc]init];
    self.list = [[NSMutableArray alloc]init];
    self.selectedIndex = [NSMutableArray array];
    self.followedlist = [[NSMutableArray alloc]init];
    [self.followedlist addObjectsFromArray:array];
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"关注指标"];
    self.view.backgroundColor = [UIColor  whiteColor];
    //设置CollectionView的属性
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.view.ct_width, self.view.ct_height-75-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    [self.view  addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerClass:[KBFollowCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, self.view.ct_height-44-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.ct_width, 44);
    bottomBtn.backgroundColor = KBCOLOR_WITH_HEX(0x6B7BFF);
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(save)
        forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bottomBtn];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.ct_height-44-33-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.ct_width, 33)];
    lable.text = @"  TIPS:只能选择展示3项关注指标";
    lable.font = [UIFont systemFontOfSize:13];
    lable.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self.view addSubview:lable];
    lable.backgroundColor = KBCOLOR_WITH_HEX(0xF2F2F2);
    
    [self follow];
    self.collectionView.userInteractionEnabled = NO;
//    [self testnetwork];
}

-(void)testnetwork
{
    
    
    NSString * targetType = [self targetTypeFromArray:self.followedlist];

    KBRequestManager *request = [[KBRequestManager alloc] initWithrequesturl:@"/tac/iocserviceselect" AndDict:@{@"userid":[KBUserInfoModel uid],@"isCheckAll":@"0"}];
//    baseData_gameColumnTime

    NSLog(@"-=-=- %@-----2  %@",targetType,[KBUserInfoModel uid]);
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        
        NSLog(@"-=-=-=-=-%@",dict);

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        NSLog(@"-=-=--%@",request.error);
    }];
    
    
    
    
}






//- (BOOL)controllerWillPopHandler
//{
//
////    UIAlertView *alter =  [[UIAlertView alloc] initWithTitle:nil message:@"请选择三个关注指标"
////                                                        delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] ;
////
////    [alter show];
//
//
//    return NO;
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
 
}

- (void)request
{
    NSString * targetType = [self targetTypeFromArray:self.followedlist];
    @KBWeakObj(self);
    
    [[KBApiLayer sharedInstance] followSetting:targetType success:^(KBBaseModel * model) {
        @KBStrongObj(self);
        if (model.code == 0)
        {
            [KBAlter show:model.desc superView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [KBAlter show:model.desc superView:self.view];
        }
    } fail:^(NSError *error) {
        [KBAlter show:@"异常" superView:self.view];
    }];
}

- (void)save
{
    if (self.followedlist.count != 3) {
        UIAlertView *alter =  [[UIAlertView alloc] initWithTitle:nil message:@"请选择三项关注指标"
                                                        delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;

        [alter show];
    }
    else
    {
        [self request];
    }
   
  
  
    
    
}

- (void)follow
{
    [KBAlter showLoadingForView:self.view];
     @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  followWithType:KBFollowWithTypAll  success:^(KBIndicatorConcernModel * model) {
         @KBStrongObj(self);
        [KBAlter hideLoadingForView:self.view];
        [self.list addObjectsFromArray:model.data.targetlist];
        for (int i  = 0 ; i < self.followedlist.count ; i++) {
            KBBottomIndicatorConcernModel *followedModel = [self.followedlist objectAtIndex:i];
            for ( int j = 0 ; j<self.list.count; j++) {
                KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:j];
                if ([allModel.targettype isEqualToString:followedModel.targettype]) {
                    allModel.isFollowed = YES;
                    if (![self.selectedIndex containsObject:@(j)]) {
                        [self.selectedIndex addObject:@(j)];
                    }
                    break;
                }
            }
        }
        
        [self.collectionView reloadData];
        self.collectionView.userInteractionEnabled = YES;
    } fail:^(NSError *error) {
         [KBAlter hideLoadingForView:self.view];
    }];
    
}

- (NSString *)targetTypeFromArray:(NSArray *)array
{
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    
    [array enumerateObjectsUsingBlock:^(KBBottomIndicatorConcernModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [mutableString appendString:model.targettype];
        if (idx != array.count-1) {
            [mutableString appendString:@","];
        }
     
    }];
    return mutableString;
}


#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
    
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    KBFollowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:indexPath.row];
    cell.isFollowed = allModel.isFollowed;
    cell.isFollowed = [self.selectedIndex containsObject:@(indexPath.row)];
    if (allModel.isFollowed) {
         [self.array addObject:cell];
//        [self.selectedIndex addObject:@(indexPath.row)];
    }
    KBBottomIndicatorConcernModel * model = [self.list objectAtIndex:indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_WIDTH < 375) {
        return CGSizeMake(92, 90);
    }
    return  CGSizeMake(115,90);
}



#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);//（上、左、下、右）
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ( self.followedlist.count >=3) {
//         [KBAlter show:@"只能选择展示3项关注指标" superView:self.view];
//        return;
//    }
     KBFollowCollectionViewCell *cell = (KBFollowCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!cell.isFollowed) {
//        if (self.array.count<3) {
        if (self.selectedIndex.count<3) {
            if (![self.selectedIndex containsObject:@(indexPath.row)]) {
                [self.selectedIndex addObject:@(indexPath.row)];
            }
//            [self.selectedIndex addObject:@(indexPath.row)];
            [self.array addObject:cell];
             KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:indexPath.row];
            [self.followedlist addObject:allModel];
            
                    if (cell) {
                        cell.isFollowed = YES;
                    }
            
        }
        else
        {
            
            [KBAlter show:@"只能选择展示3项关注指标" superView:self.view];
            
//            KBFollowCollectionViewCell *lastcell = self.array.firstObject;
//            lastcell.isFollowed = NO;
//            [self.array removeObject:lastcell];
//            [self.array addObject:cell];
//
//
//
//            KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:indexPath.row];
//            allModel.isFollowed = YES;
//
//            KBBottomIndicatorConcernModel *lastModel = self.followedlist.firstObject;
//
//            for ( int j = 0 ; j<self.list.count; j++) {
//                KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:j];
//                if ([allModel.targettype isEqualToString:lastModel.targettype]) {
//                    allModel.isFollowed = NO;
//                    break;
//                }
//            }
//            [self.followedlist removeObject:lastModel];
//            [self.followedlist addObject:allModel];
//
            
        }

    }
    else
    {
        cell.isFollowed = NO;
        [self.array removeObject:cell];
        if ([self.selectedIndex containsObject:@(indexPath.row)]) {
            [self.selectedIndex removeObject:@(indexPath.row)];
        }
        KBBottomIndicatorConcernModel *allModel = [self.list objectAtIndex:indexPath.row];
        for (int i  = 0 ; i < self.followedlist.count ; i++) {
            KBBottomIndicatorConcernModel *followedModel = [self.followedlist objectAtIndex:i];
            if ([allModel.targettype isEqualToString:followedModel.targettype]) {
                [self.followedlist removeObject:followedModel];
                break;
            }
        }
       
    }
    
   
   
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
