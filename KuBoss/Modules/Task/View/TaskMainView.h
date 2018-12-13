//
//  TaskMainView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickTaskBlock)(NSInteger index);

@interface TaskMainView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *houseImg;

@property (weak, nonatomic) IBOutlet UIImageView *accountImg;

@property (nonatomic,copy) clickTaskBlock clickTask;


@end
