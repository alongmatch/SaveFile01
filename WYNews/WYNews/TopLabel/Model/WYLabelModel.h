//
//  WYLabelModel.h
//  WYNews
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYLabelModel : NSObject

/// 频道标签名字
@property (nonatomic, copy) NSString *tname;
/// 频道ID : 后面就是根据不同的新闻的tid获取不同的新闻数据的
@property (nonatomic, copy) NSString *tid;

+ (NSArray *)getWYLabelModel;

///
/**
 "template":"manual",
 "topicid":"00040BGE",
 "hasCover":false,
 "alias":"The Truth",
 "subnum":"6.8万",
 "tag":"hot",
 "recommendOrder":0,
 "isNew":0,
 "img":"http://img2.cache.netease.com/m/newsapp/banner/zhenhua.png",
 "isHot":1,
 "hasIcon":true,
 "cid":"C1348654575297",
 "recommend":"0",
 "headLine":false,
 "tagDate":"2015-06-16 10:45:34.0",
 "color":"",
 "bannerOrder":105,
 "tname":"原创",
 "ename":"zhenhua",
 "showType":"comment",
 "special":0,
 "tid":"T1370583240249"
 },
 */
@end
