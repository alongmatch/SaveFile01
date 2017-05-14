//
//  TTBookModel.m
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTBookModel.h"

@implementation TTBookModel
//重写undefindkey规避属性少于模型造成的崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
