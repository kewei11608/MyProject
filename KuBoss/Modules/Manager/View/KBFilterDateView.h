//
//  KBFilterDateView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^filterDateViewBlock_t)(KBDateMode mode, NSInteger type,NSString *data);

typedef void (^hideSelfBlock_t)(void);

@interface KBFilterDateView : UIView

@property (nonatomic,copy) filterDateViewBlock_t filterDateBlock;
@property (nonatomic,copy) hideSelfBlock_t hideSelfBlock;

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel;

@end
