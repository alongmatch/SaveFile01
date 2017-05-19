//
//  NetworkManager.h
//  NetEaseSH05
//
//  Created by teacher on 17/5/14.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 封装的GET请求方法

 @param URLString 请求地址
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)GETWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
