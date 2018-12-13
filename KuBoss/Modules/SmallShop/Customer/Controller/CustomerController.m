//
//  CustomerController.m
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "CustomerController.h"

@interface CustomerController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图

@end

@implementation CustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"客源分析"];
    [self addLeftItem];
    [self.view addSubview:self.scrollview];
    [self initUI];
}
-(void)initUI{
    UIImageView*bgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSW/750*474)];
    bgimage.image=[UIImage imageNamed:@"Customer_bgimg"];
    [self.scrollview addSubview:bgimage];
    
}
//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, MSW, MSXH-NAVH-49)];
        _scrollview.backgroundColor=[UIColor whiteColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake(MSW, MSXH);
    }
    return _scrollview;
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
