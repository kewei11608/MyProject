//
//  HouseDoneView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseDoneView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgAgent;

@property (weak, nonatomic) IBOutlet UIImageView *imgAuditing;
@property (weak, nonatomic) IBOutlet UILabel *labeAgentTitle;
@property (weak, nonatomic) IBOutlet UILabel *labeAgentSubTitle;

@property (weak, nonatomic) IBOutlet UILabel *labeAuditTitle;

@property (weak, nonatomic) IBOutlet UILabel *labeAuditSubTitle;

@end
