//
//  WYLabelModel.m
//  WYNews
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYLabelModel.h"
#import <YYModel.h>
@implementation WYLabelModel
+(NSArray *)getWYLabelModel
{
    NSArray* modelArray=[NSArray array];
    NSString* path=[[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData* data=[NSData dataWithContentsOfFile:path];
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray* array=dic[@"tList"];
    modelArray=[NSArray yy_modelArrayWithClass:[WYLabelModel class] json:array];
    modelArray=[modelArray sortedArrayUsingComparator:^NSComparisonResult(WYLabelModel* obj1, WYLabelModel* obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    
    return modelArray;
}
@end
