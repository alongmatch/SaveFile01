//
//  TTDownloadManager.h
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TTDownloadManager : NSObject

///单例方法
+(instancetype)sharedDownloadManage;

///对象方法传入URL进行下载
-(void)downloadWithURLString:(NSString*)urlString ProgressBlock:(void(^)(float))progressBlock completion:(void (^)(NSString *))completionBlock;
///暂停
- (void)pauseDownloadWithURLString:(NSString *)URLString pauseBlock:(void(^)())pauseBlock;

/// 判断是否正在下载
- (BOOL)checkIsDownloadingWithURLString:(NSString *)URLString;
@end
