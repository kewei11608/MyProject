//
//  AcounttFreezeView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^detailBlock_t)(NSString * accountid);

typedef void (^goToLowBlock_t)();

@interface AcounttFreezeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UILabel *subLable;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic,copy)detailBlock_t detailBlock;
@property (nonatomic,copy)goToLowBlock_t goToLowBlock;

@property (nonatomic,assign) BOOL isHouse;

- (void)setModel:(KBAccountFreezeListModel *)model;


@end
