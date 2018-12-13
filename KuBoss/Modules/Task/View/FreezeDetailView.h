//
//  FreezeDetailView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/26.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseDoneView.h"


typedef void (^freezeBlock_t)(void);
typedef void (^leaveBlock_t)(void);

@interface FreezeDetailCellModel : NSObject

@property (nonatomic,copy)  NSString *preString;
@property (nonatomic,copy)  NSString *postString;
@end

@interface FreezeDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *agentNameLable;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLable;
@property (weak, nonatomic) IBOutlet UITableView *tbView;


@property (weak, nonatomic) IBOutlet UIButton *freezeBtn;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;

@property (copy, nonatomic)freezeBlock_t freezeBlock;
@property (copy, nonatomic)leaveBlock_t leaveBlock;
@property (nonatomic,copy) NSString *iphone;


- (void)setArray:(NSArray *)array;

@end
