//
//  KBSheetView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^didSelectedBlock_t)(NSInteger index);

@interface RoomSheetView : UIView
@property (nonatomic,copy)didSelectedBlock_t didSelectedBlock;
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@property (nonatomic,assign)KBSheetViewType sheetViewType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


- (void)setDataArray:(NSArray *)array;
@end
