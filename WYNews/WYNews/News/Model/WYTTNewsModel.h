//
//  WYTTNewsModel.h
//  WYNews
//
//  Created by sumshile on 2017/5/16.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYTTNewsModel : NSObject

/// 新闻标题
@property (nonatomic,copy) NSString *title;
/// 新闻图标
@property (nonatomic,copy) NSString *imgsrc;
/// 新闻来源
@property (nonatomic,copy) NSString *source;
/// 新闻回复数
@property (nonatomic,strong) NSNumber *replyCount;
/// 多张配图
@property (nonatomic, strong) NSArray *imgextra;
/// 大图标记
@property (nonatomic, assign) BOOL imgType;

@end

/*
 {
 "url_3w":"http://news.163.com/17/0515/16/CKG9A14L00018AOQ.html",
 "postid":"CKG9A14L00018AOQ",
 "votecount":1934,
 "replyCount":2073,
 "ltitle":" 押题率高达80%？河南洛阳事业单位招考被疑泄题",
 "digest":"新华社郑州5月15日电5月14日，洛阳市直和县区事业单位招考笔试结束后，有网友反映，某培训机构考前押题命中了75道公共基础知识题中的70道，并且不少题目的题号、",
 "url":"http://3g.163.com/news/17/0515/16/CKG9A14L00018AOQ.html",
 "docid":"CKG9A14L00018AOQ",
 "title":" 押题率高达80%？河南洛阳事业单位招考被疑泄题",
 "source":"新华社新媒体专线",
 "priority":89,
 "lmodify":"2017-05-15 21:57:36",
 "imgsrc":"http://cms-bucket.nosdn.127.net/8b5678b6f10544b8830264f6e22e0e9820170515181357.png",
 "subtitle":"",
 "boardid":"news2_bbs",
 "ptime":"2017-05-15 16:45:02"
 }
 */

