//
//  AgentPickerView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^didPickerBlock_t)(NSString *shopName,NSString * name , NSString *accountId);

@interface AgentPickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (copy,nonatomic)didPickerBlock_t didPickerBlock;
@property (nonatomic,assign)KBSheetViewType sheetViewType;
- (void)setArray:(NSMutableArray *)array;

@end
