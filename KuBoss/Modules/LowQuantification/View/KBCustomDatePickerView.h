//
//  KBCustomDatePickerView.h
//  Demo
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^pickViewBlock_t)(NSString *hour,NSString *min);

@interface KBCustomDatePickerView : UIView

@property (nonatomic,copy) pickViewBlock_t pickViewBlock;

@end
