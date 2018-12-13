//
//  KBRankListCell.h
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RankListCellMode) {
    RankListCellModeTop,
    RankListCellModeNoneTop,
    RankListCellModeAll,
};

@interface KBRankListTopCell : UITableViewCell
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,assign) RankListCellMode rankListCellMode;

- (void)setModel:(KBMidRankModel *)model;

@end
