//
//  HousingTopCell.h
//  CoolBroker
//
//  Created by lidan on 2018/9/14.
//  Copyright © 2018年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HousingTopCell : UITableViewCell
@property (nonatomic, strong) NSArray *ImageArray;
@property (nonatomic, copy) NSString *noimage;

@property (nonatomic, copy) void(^clicktopimageindex)(NSInteger index);

//@property (nonatomic, copy) void(^didSelectedBlock)(NSInteger index);


@end
