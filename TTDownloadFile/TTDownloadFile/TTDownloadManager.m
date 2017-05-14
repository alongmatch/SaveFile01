//
//  TTDownloadManager.m
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTDownloadManager.h"
#import "NSString+path.h"
@interface TTDownloadManager ()<NSURLSessionDownloadDelegate>


@end
@implementation TTDownloadManager {
    
    /// 全局下载的session
    NSURLSession *_downloadSession;
    /// 进度回调缓存池
    NSMutableDictionary *_progressBlockDict;
    /// 完成回调缓存池
    NSMutableDictionary *_completionBlockDict;
    /// 下载任务缓存池
    NSMutableDictionary *_downlaodTaskDict;
}


- (BOOL)checkIsDownloadingWithURLString:(NSString *)URLString
{
    if ([_downlaodTaskDict objectForKey:URLString] != nil) {
        return YES;
    }
    
    return NO;
}
+(instancetype)sharedDownloadManage

{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 实例化全局下载session
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"HM"];
        _downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        
        // 实例化进度回调缓存池 / 完成回调缓存池 / 下载任务缓存池
        _progressBlockDict = [[NSMutableDictionary alloc] init];
        _completionBlockDict = [[NSMutableDictionary alloc] init];
        _downlaodTaskDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)downloadWithURLString:(NSString *)urlString ProgressBlock:(void (^)(float))progressBlock completion:(void (^)(NSString *))completionBlock
{
    NSURL * url=[NSURL URLWithString:urlString];
    NSData* resuData=[NSData dataWithContentsOfFile:[urlString appendTempPath]];
    NSURLSessionDownloadTask* downloadTask;
    if (resuData==nil)
    {
        downloadTask= [_downloadSession downloadTaskWithURL:url];
    }
    else
    {
        downloadTask=[_downloadSession downloadTaskWithResumeData:resuData];
        //移除沙盒的数据
        [[NSFileManager defaultManager] removeItemAtPath:[urlString appendTempPath] error:NULL];
    }
    // 提示 : 以downloadTask作为key的目的是,需要在代理里面取这个回调,但是代理方法只有downloadTask
    [_progressBlockDict setObject:progressBlock forKey:downloadTask];
    [_completionBlockDict setObject:completionBlock forKey:downloadTask];
    [_downlaodTaskDict setObject:downloadTask forKey:urlString];
    [downloadTask resume];
    
}
#pragma mark
#pragma mark - 暂停
-(void)pauseDownloadWithURLString:(NSString *)URLString pauseBlock:(void (^)())pauseBlock
{
    NSURLSessionDownloadTask* downloadTask=[_downlaodTaskDict objectForKey:URLString];
    if (downloadTask!=nil)
    {
        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            [resumeData writeToFile:[URLString appendTempPath] atomically:YES];
            [_progressBlockDict removeObjectForKey:downloadTask];
            [_completionBlockDict removeObjectForKey:downloadTask];
            [_downlaodTaskDict setObject:downloadTask forKey:URLString];
        }];
        if(pauseBlock!=nil)
        {
            pauseBlock();
        }
    }
}

#pragma mark
#pragma mark - 代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //    NSLog(@"DownloadManager 文件下载完成 %@",location.path);
    
    // 1.把下载完成的音频文件缓存到沙盒
    NSString *URLString = downloadTask.currentRequest.URL.absoluteString;
    NSString *fileName = [URLString lastPathComponent];
    NSString *savePath = [NSString stringWithFormat:@"/Users/sumshile/Desktop/%@",fileName];
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:savePath error:NULL];
    
    // 2.取出下载完成回调
    void(^completionBlock)(NSString *) = [_completionBlockDict objectForKey:downloadTask];
    
    // 3.回调路径到控制器
    if (completionBlock) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionBlock(savePath);
        }];
    }
    
    // 4.下载完成之后把相关缓存池清空
    [_progressBlockDict removeObjectForKey:downloadTask];
    [_completionBlockDict removeObjectForKey:downloadTask];
    [_downlaodTaskDict removeObjectForKey:URLString];
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    void (^progressBlock)(float) = [_progressBlockDict objectForKey:downloadTask];
    if (progressBlock) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            progressBlock(progress);
        }];
    }
}

@end
