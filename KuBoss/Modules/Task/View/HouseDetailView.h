//
//  HouseDetailView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseDoneView.h"

typedef void (^roomDetailBlock_t)(void);
typedef void (^refuseBlock_t)(void);
typedef void (^agreeBlock_t)(void);

@interface HouseDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *testLable;

@property (nonatomic,copy)roomDetailBlock_t roomDetailBlock;
@property (nonatomic,copy)refuseBlock_t refuseBlock;
@property (nonatomic,copy)agreeBlock_t agreeBlock;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *officeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *numberIdLable;
@property (weak, nonatomic) IBOutlet UILabel *numberTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *launchTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *runTimeLable;


@property (weak, nonatomic) IBOutlet UILabel *roomCodeLable;
@property (weak, nonatomic) IBOutlet UILabel *propertyNameLable;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLable;
@property (weak, nonatomic) IBOutlet UIView *clickView;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *explainLable;
@property (copy, nonatomic) NSString *phone;
@property (nonatomic,strong)HouseDoneView *doneView;
@end
