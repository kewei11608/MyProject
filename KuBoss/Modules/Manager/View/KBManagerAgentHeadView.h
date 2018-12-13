//
//  KBManagerAgentHeadView.h
//  KuBoss
//
//  Created by sunruixue on 2018/4/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^agentMoreBlock_t)();
typedef void (^filterVHousingBlock_t)(NSInteger housingType);
typedef void (^filterVDateViewBlock_t)(KBDateMode mode, NSInteger type,NSString *data);
@interface KBManagerAgentHeadView : UIView
@property (nonatomic,copy) agentMoreBlock_t agentMoreBlock;
@property (nonatomic,copy) filterVHousingBlock_t filterHousingBlock;
@property (nonatomic,copy) filterVDateViewBlock_t filterVDateViewBlock;
@property (nonatomic,copy) tellBlock_t tellBlock;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic, strong) UILabel *noDataLabel;
- (void)setModel:(KBBottomShopAgentModel *)model;

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel;

- (void)setAgentModel:(KBAgenListModel *)agentModel;

- (void)loadWebViewradarChatTimeType:(NSString *)timeType
                    daterange:(NSString *)daterange
                  housingtype:(NSString *)housingtype
                             agentId:(NSString *)agentId;

@end
