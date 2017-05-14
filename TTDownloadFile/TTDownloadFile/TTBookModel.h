//
//  TTBookModel.h
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TTBookModel : NSObject

///名字
@property(nonatomic,copy)NSString* name;

///下载状态
@property(nonatomic,assign)BOOL downSelected;

///下载路径
@property(nonatomic,copy)NSString* path;

///下载进度
@property(nonatomic,assign)CGFloat parg;

/**
 buy : 0
 downPrice : 0
 feeType : 0
 hasLyric : 0
 id : 301500958
 length : 1239
 listenPrice : 0
 name : "第001集_回到古代当兽医"
 path : "http://kting.info:81/asdb/fiction/chuanyue/hdgddsy/r4jigc2a.mp3"
 payType : 0
 section : 1
 size : 9913859
 strategy : 0
 */
@end
