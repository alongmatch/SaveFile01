//
//  Activity_listModel.h
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/10.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity_listModel : NSObject
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,copy)NSString* img_url;
@property(nonatomic,copy)NSString* title_color;
@property(nonatomic,copy)NSString* desc_color;
@property(nonatomic,copy)NSString* background_color;


/**
 
 title : "美食游园会"
 desc : "5.1元吃大牌"
 head_icon : "https://img.waimai.baidu.com/pb/cce7dc75d0cfca37147fd2e696cc851eb3@w_,h_,s_0,f_png,l_1"
 img_url : "https://img.waimai.baidu.com/pb/1f75987733cc05abb5e8b134daecb5fd1c@w_,h_,s_0,f_png,l_1"
 spec_icon : ""
 activity_url : "bdwm://native?pageName=webview&url=https%3A%2F%2Fwaimai.baidu.com%2Ffly%2Fh5%2FadvancedTemplate%3Fgame_id%3D18849%26utm_campaign%3D22%26utm_source%3Dwaimai%26utm_medium%3Dwaimai%26cid%3D100005979%26needlocation%3D1%26lng%3D13538713.207818%26lat%3D3615772.560023&contentType=HD&contentId=18849&header=1"
 count_down_time : ""
 next_seckill : ""
 title_color : "#73300F"
 desc_color : "#a9a9a9"
 background_color : "#F8F1E8"
 */
@end
