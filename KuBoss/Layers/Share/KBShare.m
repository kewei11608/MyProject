//
//  KBShare.m
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShare.h"

@implementation KBShare

+ (void)shareScene:(NSInteger) scene title:(NSString *)title  url:(NSString *)url content:(NSString *)content imgurl:(NSString *)imgurl
{
    
    SendMessageToWXReq *req1 = [[SendMessageToWXReq alloc]init];
    
    // 是否是文档
    req1.bText =  NO;
    
    //    WXSceneSession  = 0,        /**< 聊天界面    */
    //    WXSceneTimeline = 1,        /**< 朋友圈      */
    //    WXSceneFavorite = 2,
    
    
    req1.scene = WXSceneSession;
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title;//分享标题
    urlMessage.description = content;//分享描述
//    [urlMessage setThumbImage:[UIImage imageNamed:@"XXshar"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
//
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = url;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    req1.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:req1];
    
}
@end
