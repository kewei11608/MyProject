//
//  KBBanerModel.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseModel.h"

//首页Banner

@interface KBBottomBanerModel : NSObject

@property (nonatomic,copy) NSString *cmModifieddate;
@property (nonatomic,copy) NSString *cmReleasedate;
@property (nonatomic,copy) NSString *cmState;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *imgid; //唯一id
@property (nonatomic,copy) NSString *imgname; //图片名称
@property (nonatomic,copy) NSString *imgurl; //图像地址
@property (nonatomic,copy) NSString *publishingArea;
@property (nonatomic,copy) NSString *redrectURL; //跳转网址
@property (nonatomic,copy) NSString *redrectView; //跳转APP页面
@property (nonatomic,copy) NSString *userid;


@end

@interface KBMidBanerModel : NSObject
@property (nonatomic,strong)NSArray *targetlist;
@property (nonatomic,copy)  NSString *userid;
@end

@interface KBBanerModel : KBBaseModel
@property (nonatomic,strong)KBMidBanerModel *data;
@end
