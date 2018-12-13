//
//  KBRBAgentView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KBRBAgentView : UIView
@property (nonatomic,copy) tellBlock_t tellBlock;

- (void)setName:(NSString *)name shop:(NSString *)shop iphone:(NSString *)phone avatarUrl:(NSString *)avatarUrl;

@end
