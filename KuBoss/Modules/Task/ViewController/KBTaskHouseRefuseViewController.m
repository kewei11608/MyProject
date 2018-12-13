//
//  KBTaskHouseRefuseViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskHouseRefuseViewController.h"
#import "HouseRefuseView.h"

@interface KBTaskHouseRefuseViewController ()
@property (nonatomic,strong)HouseRefuseView *mainView;

@end

@implementation KBTaskHouseRefuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setCustomTitle:@"审批拒绝"];
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    @KBWeakObj(self);
    self.mainView.submitBlock = ^(NSString *input) {
        @KBStrongObj(self);
        if (self.submitBlock) {
            self.submitBlock(input);
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HouseRefuseView *)mainView {
    if (!_mainView) {
        _mainView = [HouseRefuseView loadViewFrom:@"HouseRefuseView"];
    }
    return _mainView;
}




@end
