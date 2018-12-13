//
//  WHBaseModel.h
//  Pods
//
//  Created by yuyang on 2018/5/2.
//

#import <Foundation/Foundation.h>

@interface KBBaseModel : NSObject
@property (nonatomic, assign) NSInteger        code;
@property (nonatomic, copy  ) NSString         *desc;
@property (nonatomic, strong) id               data;
@property (nonatomic, assign) NSInteger maxRow;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end
