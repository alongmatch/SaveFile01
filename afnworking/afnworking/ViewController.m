//
//  ViewController.m
//  afnworking
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url=[NSURL URLWithString:@"http://127.0.0.1/php/login/login.html"];
    NSMutableDictionary* parameters=[NSMutableDictionary dictionary];
    parameters[@"userName"]=@"zhangsan";
    parameters[@"password"]=@"zhang";
    [[AFHTTPSessionManager manager]POST:@"http://127.0.0.1/php/login/login.html" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject class]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
