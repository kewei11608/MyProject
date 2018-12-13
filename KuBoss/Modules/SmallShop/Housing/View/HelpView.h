//
//  HelpView.h
//  KuBoss
//
//  Created by lidan on 2018/11/23.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpView : UIView
- (instancetype)initWithdata:(NSDictionary*)dic action:(void(^)(NSInteger index))action;
+ (void)showWithdata:(NSDictionary*)dic action:(void(^)(NSInteger index))action;
- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
