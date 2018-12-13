//
//  QrCodeimgView.h
//  ddcp
//
//  Created by lidan on 2018/5/17.
//  Copyright © 2018年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QrCodeimgView : UIView
@property (nonatomic, strong) NSString           *urlstr; //
- (instancetype)initWithimgurl:(NSDictionary*)dic action:(void(^)(NSInteger index))action;
+ (void)showWithimgurl:(NSDictionary*)dic action:(void(^)(NSInteger index))action;
- (void)show;
- (void)hide;

@end
