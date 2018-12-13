//
//  KBBusinessManagerView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectedBlock_t)( KBListRBModel *shopListModel);
typedef void (^filterHousingBlock_t)(NSInteger housingType);
typedef void (^filterDateBlock_t)(KBDateMode mode, NSInteger type);
@interface KBBusinessManagerView : UIView
@property (nonatomic,copy)selectedBlock_t selectedBlock;
@property (nonatomic,copy)filterDateBlock_t filterDateBlock;
@property (nonatomic,copy)filterHousingBlock_t filterHousingBlock;

- (void)setBusinessModel:(KBRBHomeModel *)model;

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel;

- (void)reload;

@end
